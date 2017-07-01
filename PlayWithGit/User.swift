//
//  User.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

struct User {
    
    var id = ""
    var username = ""
    var avatarUrl = ""
    var repositoriesUrl = ""
    var followingList: [User] = []
    
    mutating func populateWithDict(dict: [String: Any]) {
        
        if let id = dict["id"] as? NSNumber {
            self.id = id.stringValue
        }

        username = dict["login"] as? String ?? ""
        avatarUrl = dict["avatar_url"] as? String ?? ""
        repositoriesUrl = dict["repos_url"] as? String ?? ""
    }
}
