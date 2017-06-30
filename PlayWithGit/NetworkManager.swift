//
//  NetworkManager.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class NetworkManager {
    
    //MARK: private vars
    
    private static let BASE_URL = "https://api.github.com"
    
    private static var cache: NSCache<NSString, UIImage> = NSCache()
    
    //MARK: public vars
    
    static var sessionUsername: String?
    static var sessionPassword: String?
    static var loggedUser: User?
    
    //MARK: private network methods
    
    private class func executeRequest(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        
        if let username = sessionUsername, let password = sessionPassword {
            
            let credentialsData = "\(username):\(password)".data(using: String.Encoding.utf8)
            
            if let credentialsInBase64 = credentialsData?.base64EncodedString(options: []) {
                let authorization = "Basic \(credentialsInBase64)"
                request.addValue(authorization, forHTTPHeaderField: "Authorization")
            }
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            logRequest(request: request, response: response as? HTTPURLResponse, data: data, error: error)
            completion(data, response, error)
        }.resume()
    }
    
    //MARK: public network methods
    
    class func loginWithCredentials(username: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let url = URL(string: BASE_URL) else {
            completion(false)
            return
        }
        
        sessionUsername = username
        sessionPassword = password
        
        executeRequest(url: url) { (data, response, error) in
            
            var success = false
            
            defer {
                DispatchQueue.main.sync {
                    completion(success)
                }
            }
            
            if error == nil, (response as? HTTPURLResponse)?.statusCode == 200 {
                success = true
            } else {
                sessionUsername = nil
                sessionPassword = nil
            }
        }
    }
    
    class func getUserForUsername(username: String, completion: @escaping (_ user: User?) -> Void) {
        
        guard let url = URL(string: "\(BASE_URL)/users/\(username)") else {
            completion(nil)
            return
        }
        
        executeRequest(url: url) { (data, response, error) in
            
            var user: User?
            
            defer {
                DispatchQueue.main.sync {
                    completion(user)
                }
            }
            
            if let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 {

                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

                    var newUser = User()
                    newUser.populateWithDict(dict: json)
                    user = newUser
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
        }
    }
    
    class func getFollowersForUsername(username: String, completion: @escaping ([User]) -> Void) {

        guard let url = URL(string: "\(BASE_URL)/users/\(username)/followers") else {
            completion([])
            return
        }
        
        executeRequest(url: url) { (data, response, error) in
            
            var followingList: [User] = []
            
            defer {
                DispatchQueue.main.sync {
                    completion(followingList)
                }
            }
            
            if let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]

                    for userDict in json {
                        
                        var user = User()
                        user.populateWithDict(dict: userDict)
                        
                        followingList.append(user)
                    }
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
        }
    }
    
    class func getFollowingForUsername(username: String, completion: @escaping ([User]) -> Void) {

        guard let url = URL(string: "\(BASE_URL)/users/\(username)/following") else {
            completion([])
            return
        }
        
        executeRequest(url: url) { (data, response, error) in
            
            var followingList: [User] = []
            
            defer {
                DispatchQueue.main.sync {
                    completion(followingList)
                }
            }
            
            if let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]

                    for userDict in json {
                        
                        var user = User()
                        user.populateWithDict(dict: userDict)
                        
                        followingList.append(user)
                    }
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
        }
    }
    
    class func getAvatarForUser(user: User, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: user.avatarUrl) else {
            completion(nil)
            return
        }
        
        if let image = NetworkManager.cache.object(forKey: user.avatarUrl as NSString) {
            completion(image)
        } else {
            executeRequest(url: url) { (data, response, error) in
                
                var image: UIImage?
                
                defer {
                    DispatchQueue.main.sync {
                        completion(image)
                    }
                }
                
                if let data = data, let downloadedImage = UIImage(data: data), (response as? HTTPURLResponse)?.statusCode == 200 {
                    image = downloadedImage
                    NetworkManager.cache.setObject(downloadedImage, forKey: user.avatarUrl as NSString)
                } else {
                    print("Error downloading image with url: \(url.absoluteString)")
                }
                
            }
        }
    }
    
    class func getRepositoriesForUser(user: User, completion: @escaping ([Repository]) -> Void) {
        
        guard let url = URL(string: user.repositoriesUrl) else {
            completion([])
            return
        }
        
        executeRequest(url: url) { (data, response, error) in
            
            var repositoriesList: [Repository] = []
            
            defer {
                DispatchQueue.main.sync {
                    completion(repositoriesList)
                }
            }
            
            if let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                    
                    for RepoDict in json {
                        
                        var repository = Repository()
                        repository.populateWithDict(dict: RepoDict)
                        
                        repositoriesList.append(repository)
                    }
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
        }
    }
    
    //MARK: helpers
    
    class func isLoginRequired() -> Bool {
        let loginRequired = (sessionUsername == nil || sessionPassword == nil)
        return loginRequired
    }
    
    class func logRequest(request: URLRequest, response: HTTPURLResponse?, data: Data?, error: Error?) {
        
        let urlString = request.url?.absoluteString ?? ""
        let httpMethod = request.httpMethod ?? ""

        print("\n------------------------------")
        
        // url and method
        print("REQUEST(\(httpMethod)): \(urlString)\n")
        
        // headers
        print("REQUEST HEADERS:")
        if let headersDict = request.allHTTPHeaderFields {
            for key in headersDict.keys {
                guard let value = headersDict[key] else { continue }
                print("\(key) = \(value)")
            }
        }

        // response
        if let response = response {
            print("\nRESPONSE(\(response.statusCode))")
            
            let contentType = response.allHeaderFields["Content-Type"] as? String ?? ""
            
            if let data = data, contentType.contains("application/json") {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as Any
                    print(json)
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
            
        } else {
            print("\nNO RESPONSE")
        }
        
        print("------------------------------")
    }
}
