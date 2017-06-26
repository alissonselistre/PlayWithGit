//
//  UserTableViewCell.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func configureUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        
        followersButton.layer.masksToBounds = true
        followersButton.layer.cornerRadius = 8
        
        followingButton.layer.masksToBounds = true
        followingButton.layer.cornerRadius = 8
    }
    
    private func resetUI() {
        avatarImageView.image = UIImage(named: "placeholder_profile")
        nameLabel.text = "Name"
        usernameLabel.text = "username"
    }
}
