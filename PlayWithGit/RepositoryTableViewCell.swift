//
//  RepositoryTableViewCell.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 27/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        nameLabel.text = ""
        descriptionLabel.text = ""
        languageLabel.text = ""
    }
}
