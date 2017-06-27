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
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCellIdentifier", for: indexPath) as! RepositoryTableViewCell
        
        return cell
    }
}
