//
//  UserDetailViewController.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 27/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    var user: User?
    var repositories: [Repository] = []
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        if NetworkManager.isLoginRequired() {
            showLoginView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if needsToPopulateUI() {
            if let user = user {
                getUserInformationAndUpdateUI(user: user)
            } else if let loggedUser = NetworkManager.loggedUser {
                getUserInformationAndUpdateUI(user: loggedUser)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserListSegueIdentifier" {
            
            guard let userList = sender as? [User] else { return }
            guard let userListViewController = segue.destination as? UserListViewController else { return }
            
            userListViewController.userList = userList
        }
    }
    
    private func configureUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
        usernameLabel.text = nil
    }
    
    //MARK: actions
    
    @IBAction func FollowersButtonPressed(_ sender: UIButton) {
        
        if let user = user {
            NetworkManager.getFollowersForUsername(username: user.username) { (followers) in
                if followers.count > 0 {
                    self.performSegue(withIdentifier: "UserListSegueIdentifier", sender: followers)
                } else {
                    Alert.showMessage(title: nil, message: "There is no followers to show =(")
                }
            }
        }
    }
    
    @IBAction func FollowingButtonPressed(_ sender: UIButton) {
        
        if let user = user {
            NetworkManager.getFollowingForUsername(username: user.username) { (following) in
                if following.count > 0 {
                    self.performSegue(withIdentifier: "UserListSegueIdentifier", sender: following)
                } else {
                    Alert.showMessage(title: nil, message: "There is no following to show =(")
                }
            }
        }
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCellIdentifier", for: indexPath) as! RepositoryTableViewCell
        
        let repository = repositories[indexPath.row]
        
        cell.nameLabel.text = repository.name
        cell.descriptionLabel.text = repository.description
        cell.languageLabel.text = repository.language
        
        return cell
    }
    
    //MARK: helpers
    
    private func getUserInformationAndUpdateUI(user: User) {
        
        self.user = user
        
        usernameLabel.text = user.username
        
        NetworkManager.getAvatarForUser(user: user) { (image) in
            guard let image = image else { return }
            self.avatarImageView.image = image
        }
        
        NetworkManager.getRepositoriesForUser(user: user) { (repositories) in
            if repositories.count > 0 {
                self.repositories = repositories
                self.repositoriesTableView.reloadData()
            }
        }
    }
    
    private func needsToPopulateUI() -> Bool {
        return (usernameLabel.text == nil)
    }
    
    private func showLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController, animated: false, completion: nil)
    }
    
    private func showUserListView(userList: [User]) {
        performSegue(withIdentifier: "UserListSegueIdentifier", sender: userList)
    }
}
