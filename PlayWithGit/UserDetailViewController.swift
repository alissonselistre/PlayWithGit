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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if NetworkManager.isLoginRequired() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginViewController, animated: true, completion: nil)
        } else {
            
            if let user = user {
                getUserInformationAndUpdateUI(user: user)
            } else if let loggedUser = NetworkManager.loggedUser {
                getUserInformationAndUpdateUI(user: loggedUser)
            }
        }
    }
    
    private func configureUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
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
        
        usernameLabel.text = user.username
        
        NetworkManager.getAvatarForUser(user: user) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.sync {
                self.avatarImageView.image = image
            }
        }
        
        NetworkManager.getRepositoriesForUser(user: user) { (repositories) in
            if repositories.count > 0 {
                
                DispatchQueue.main.sync {
                    self.repositories = repositories
                    self.repositoriesTableView.reloadData()
                }
            }
        }
    }
}
