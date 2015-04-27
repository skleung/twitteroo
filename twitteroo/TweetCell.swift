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
  @IBOutlet var favoriteIcon: UIImageView!
  @IBOutlet var retweetIcon: UIImageView!
  var tweet: Tweet?
    override func awakeFromNib() {
        super.awakeFromNib()
      let retweetGesture = UITapGestureRecognizer(target: self, action: "retweetTapped:")
      let favoriteGesture = UITapGestureRecognizer(target: self, action: "favoriteTapped:")
      // add it to the image view;
      retweetIcon.addGestureRecognizer(retweetGesture)
      favoriteIcon.addGestureRecognizer(favoriteGesture)

    }
  
  func retweetTapped(gesture: UIGestureRecognizer) {
    // if the tapped view is a UIImageView then set it to imageview
    if let retweetIcon = gesture.view as? UIImageView {
      TwitterClient.sharedInstance.retweet(tweet?.id, completion: { (status, error) -> () in
        if (error == nil) {
          retweetIcon.image = UIImage(named: "retweet_on")
        }
      })
      //Here you can initiate your new ViewController
      
    }
  }
  
  func favoriteTapped(gesture: UIGestureRecognizer) {
    // if the tapped view is a UIImageView then set it to imageview
    if let favoriteIcon = gesture.view as? UIImageView {
      var params = [String:Int]()
      params["id"] = tweet!.id!
      println(params)
      if (tweet!.favorited!) {
        TwitterClient.sharedInstance.unfavorite(params, completion: { (status, error) -> () in
          if (error == nil) {
            favoriteIcon.image = UIImage(named: "favorite")
          }
        })
      } else {
        
        TwitterClient.sharedInstance.favorite(params, completion: { (status, error) -> () in
          if (error == nil) {
            favoriteIcon.image = UIImage(named: "favorite_on")
          }
        })
      }
      
      
    }
  }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
  
    func setupCell(t: Tweet) {
      self.tweet = t
      tweetLabel.text = t.text
      var url = NSURL(string: t.user!.profileImageUrl!)
      photoView.setImageWithURL(url)
      nameLabel.text = t.user!.name
      handleLabel.text = "@" + t.user!.screenname!
      timeLabel.text = t.createdAt?.shortTimeAgoSinceNow()
      if (tweet!.favorited!) {
        favoriteIcon.image = UIImage(named: "favorite_on")
      }
      if (tweet!.retweeted!) {
        retweetIcon.image = UIImage(named: "retweet_on")
      }
    }

}
