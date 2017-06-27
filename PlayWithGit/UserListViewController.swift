//
//  UserListViewController.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var userList: [User] = []
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getUserForUsername(username:"alissonselistre") { (user) in
            if let user = user {
                self.userList = [user]
                self.tableView.reloadData()
            }
        }
    }

    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! UserTableViewCell
        
        let user = userList[indexPath.row]
        
        cell.usernameLabel.text = user.username
        cell.idLabel.text = user.id
        
        return cell
    }
}

