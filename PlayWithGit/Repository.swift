//
//  Repository.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 29/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

struct Repository {
    
    let id: NSNumber
    let name: String
    let description: String
    let language: String
    let url: URL
    
    init?(dict: [String: Any]) {
        guard let repoId = dict["id"] as? NSNumber,
            let name = dict["name"] as? String,
            let description = dict["description"] as? String,
            let language = dict["language"] as? String,
            let urlString = dict["html_url"] as? String,
            let url = URL(string: urlString) else {
                return nil
        }
        self.id = repoId
        self.name = name
        self.description = description
        self.language = language
        self.url = url
    }
}
