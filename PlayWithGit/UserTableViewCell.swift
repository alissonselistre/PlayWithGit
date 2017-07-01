//
//  UserTableViewCell.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 26/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: class {
    func followButtonPressed(in cell:UserTableViewCell)
    func unfollowButtonPressed(in cell:UserTableViewCell)
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var followUnfollowButton: UIButton!
    
    weak var delegate: UserTableViewCellDelegate?
    
    var user: User?
    
    //MARK: view methods
    
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
        
        followUnfollowButton.layer.masksToBounds = true
        followUnfollowButton.layer.cornerRadius = 6
    }
    
    private func resetUI() {
        avatarImageView.image = UIImage(named: "placeholder_profile")
        usernameLabel.text = "username"
        idLabel.text = ""
        followUnfollowButton.setTitle("Follow", for: UIControlState.normal)
        followUnfollowButton.backgroundColor = UIColor.customRed
    }
    
    //MARK: actions
    
    @IBAction func followUnfollowButtonPressed(_ sender: Any) {
        if isFollowing() {
            delegate?.unfollowButtonPressed(in: self)
        } else {
            delegate?.followButtonPressed(in: self)
        }
    }
    
    //MARK: helpers
    
    private func isFollowing() -> Bool {
        var isFollowing: Bool?
        isFollowing = NetworkManager.sessionUser?.followingList.contains(where: { $0.username == user?.username})
        return (isFollowing != nil ?? false)
    }
    
    func updateFollowUnfollowButtonStatus() {
        
        var buttonTitle = "Follow"
        var buttonColor = UIColor.customRed
        
        if isFollowing() {
            buttonTitle = "Unfollow"
            buttonColor = UIColor.gray
        }
        
        followUnfollowButton.setTitle(buttonTitle, for: UIControlState.normal)
        followUnfollowButton.backgroundColor = buttonColor
    }
}
