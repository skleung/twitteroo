//
//  StatsCell.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/5/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {

  @IBOutlet var numFollowingLabel: UILabel!
  @IBOutlet var numFollowersLabel: UILabel!
  @IBOutlet var numTweetsLabel: UILabel!
  var user: User!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setUpCell() {
    numFollowersLabel.text = user.numFollowers
    numFollowingLabel.text = user.numFollowing
    numTweetsLabel.text = user.numTweets
  }

}
