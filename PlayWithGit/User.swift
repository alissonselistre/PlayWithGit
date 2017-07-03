//
//  User.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import Foundation

struct User {
    
    let id: NSNumber
    let username: String
    let avatarUrl: String
    let repositoriesUrl: URL
    var followingList: [User] = []
    
    init?(dict: [String: Any]) {
        guard let userId = dict["id"] as? NSNumber,
        let username = dict["login"] as? String,
        let avatar = dict["avatar_url"] as? String,
        let repositories = dict["repos_url"] as? String,
        let repositoriesUrl = URL(string: repositories) else {
             return nil
        }

        self.id = userId
        self.username = username
        self.avatarUrl = avatar
        self.repositoriesUrl = repositoriesUrl
    }
}
