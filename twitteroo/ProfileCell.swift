//
//  ProfileCell.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

  @IBOutlet var numFollowersLabel: UILabel!
  @IBOutlet var handleLabel: UILabel!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var profilePhotoView: UIImageView!
    var user:User!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = user.name
        handleLabel.text = user.screenname
        profilePhotoView.setImageWithURL(NSURL(string: user.profileImageUrl!))
        numFollowersLabel.text = user.numFollowers
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
