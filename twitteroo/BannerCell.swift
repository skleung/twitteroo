//
//  BannerCell.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/5/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell {

  @IBOutlet var handleLabel: UILabel!
  @IBOutlet var nameLabl: UILabel!
  @IBOutlet var profileImage: UIImageView!
  @IBOutlet var bannerImage: UIImageView!
  var user:User!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setUpCell() {
    bannerImage.setImageWithURL(NSURL(string: user.bannerImageUrl!))
    profileImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
    
    handleLabel.text = "@" + user.screenname!
    nameLabl.text = user.name
    profileImage.layer.zPosition = 2
    handleLabel.layer.zPosition = 2
    nameLabl.layer.zPosition = 2

  }

}
