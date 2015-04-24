//
//  TweetCell.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/23/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet var photoView: UIImageView!
  @IBOutlet var tweetLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
