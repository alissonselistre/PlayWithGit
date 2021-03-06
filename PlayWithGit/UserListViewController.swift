//
//  UserListViewController.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var userList: [User] = []
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserDetailSegueIdentifier" {
            guard let user = sender as? User else { return }
            guard let userDetailViewController = segue.destination as? UserDetailViewController else { return }
            userDetailViewController.user = user
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
        cell.delegate = self
        
        let user = userList[indexPath.row]
        
        cell.user = user
        cell.usernameLabel.text = user.username
        cell.idLabel.text = user.id.stringValue
        cell.updateFollowUnfollowButtonStatus()
        
        NetworkManager.getAvatarForUser(user: user) { (image) in
            if user.id == cell.user?.id {
                cell.avatarImageView.image = image
            }
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userList[indexPath.row]
        performSegue(withIdentifier: "UserDetailSegueIdentifier", sender: user)
    }
    
    //MARK: UserTableViewCellDelegate
    
    func followButtonPressed(in cell: UserTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let user = userList[indexPath.row]
        
        NetworkManager.followUser(username: user.username) { (success) in
            Alert.showSuccessMessage(message: "You are now following \(user.username).")
        }
    }
    
    func unfollowButtonPressed(in cell: UserTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let user = userList[indexPath.row]
        
        NetworkManager.unfollowUser(username: user.username) { (success) in
            Alert.showSuccessMessage(message: "You are not following \(user.username) anymore.")
        }
    }
}

