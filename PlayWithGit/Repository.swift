//
//  Repository.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 29/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

struct Repository {
    
    var id = ""
    var name = ""
    var description = ""
    var language = ""
    
    mutating func populateWithDict(dict: [String: Any]) {
        
        if let id = dict["id"] as? NSNumber {
            self.id = id.stringValue
        }
        
        name = dict["name"] as? String ?? ""
        description = dict["description"] as? String ?? ""
        language = dict["language"] as? String ?? ""
    }
}
