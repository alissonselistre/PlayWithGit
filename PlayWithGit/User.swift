//
//  User.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import Foundation

struct User {
    var id = ""
    var username = ""
    var avatarUrl = ""
    
    mutating func populateWithDict(dict: [String:Any]) {
        id = dict["id"] as? String ?? ""
        username = dict["login"] as? String ?? ""
        avatarUrl = dict["avatar_url"] as? String ?? ""
    }
}
