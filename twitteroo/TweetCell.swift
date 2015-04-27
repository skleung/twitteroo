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
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var handleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
  
    func setupCell(t: Tweet) {
      tweetLabel.text = t.text
      var url = NSURL(string: t.user!.profileImageUrl!)
      photoView.setImageWithURL(url)
      nameLabel.text = t.user!.name
      handleLabel.text = "@" + t.user!.screenname!
      timeLabel.text = t.createdAt?.shortTimeAgoSinceNow()
    }

}
