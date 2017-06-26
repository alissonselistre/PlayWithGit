//
//  NetworkManager.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class NetworkManager {
    
    //MARK: private
    
    private static let BASE_URL = "https://api.github.com/users"
    private static let DEFAULT_USER = "alissonselistre"
    
    private static var cache: NSCache<NSString, UIImage> = NSCache()
    
    //MARK: public
    
    class func getFollowersForUsername(username: String, completion: @escaping ([User]) -> Void) {

        guard let url = URL(string: "\(BASE_URL)/\(username)/followers") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            var followingList: [User] = []
            
            defer {
                completion(followingList)
            }
            
            if let data = data, error == nil {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String:String]]
                    
                    print("JSON downloaded properly.")
                    
                    for UserDict in json {
                        
                        var user = User()
                        user.id = UserDict["id"] ?? ""
                        user.username = UserDict["login"] ?? ""
                        
                        followingList.append(user)
                    }
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
            
            }.resume()
    }
    
    class func getFollowingForUsername(username: String, completion: @escaping ([User]) -> Void) {

        guard let url = URL(string: "\(BASE_URL)/\(username)/following") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            var followingList: [User] = []
            
            defer {
                completion(followingList)
            }
            
            if let data = data, error == nil {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data) as! [[String:String]]
                    
                    print("JSON downloaded properly.")
                    
                    for UserDict in json {
                        
                        var user = User()
                        user.id = UserDict["id"] ?? ""
                        user.username = UserDict["login"] ?? ""
                        
                        followingList.append(user)
                    }
                    
                } catch {
                    print("Error when parsing the JSON: \(error)")
                }
            }
            
        }.resume()
    }
    
    class func downloadAvatarForUser(user: User, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: user.avatarUrl) else {
            completion(nil)
            return
        }
        
        if let image = NetworkManager.cache.object(forKey: user.id as NSString) {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
                
                var image: UIImage?
                
                defer {
                    completion(image)
                }
                
                if let data = data, let downloadedImage = UIImage(data: data) {
                    image = downloadedImage
                    NetworkManager.cache.setObject(downloadedImage, forKey: user.id as NSString)
                } else {
                    print("Error downloading image with url: \(url.absoluteString)")
                }
                
            }.resume()
        }
    }
}
