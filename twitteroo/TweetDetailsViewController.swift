//
//  TweetDetailsViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/26/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

  @IBOutlet var photoView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var tweetLabel: UILabel!
  @IBOutlet var handleLabel: UILabel!
  @IBOutlet var timestampLabel: UILabel!
  @IBOutlet var numRetweetsLabel: UILabel!
  @IBOutlet var numFavoritesLabel: UILabel!
  
  @IBOutlet var retweetLabel: UILabel!
  @IBOutlet var inReplyLabel: UILabel!
  @IBOutlet var retweetIcon: UIImageView!
  @IBOutlet var replyIcon: UIImageView!
  @IBOutlet var favoriteIcon: UIImageView!
  var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetails(tweet!)
        self.view.viewWithTag(1)?.hidden = true
        self.view.viewWithTag(2)?.hidden = true
        self.view.viewWithTag(3)?.hidden = true
        if (tweet?.replyText != nil) {
          self.view.viewWithTag(1)?.hidden = false
          inReplyLabel.text = tweet!.replyText
        }
        if (tweet?.retweetText != nil) {
          self.view.viewWithTag(2)?.hidden = false
          retweetLabel.text = tweet!.retweetText
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if (segue.identifier == "reply_segue") {
        var composeVC = segue.destinationViewController as! ComposeViewController
        composeVC.delegate = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        // removes details from the navbar controller stack
        navigationController?.popToRootViewControllerAnimated(false)
        composeVC.replyId = tweet!.id
        composeVC.replyScreenname = tweet!.replyScreenname
      }
    }
  
  func setDetails(t: Tweet) {
    nameLabel.text = t.user?.name
    handleLabel.text = "@" + t.user!.screenname!
    var url = NSURL(string: t.user!.profileImageUrl!)
    photoView.setImageWithURL(url!)
    timestampLabel.text = t.createdAt?.formattedDateWithFormat("dd/MM/yyyy hh:mm a")
    tweetLabel.text = t.text
    numFavoritesLabel.text = "\(t.numFavorites!)"
    numRetweetsLabel.text = "\(t.numRetweets!)"
    if (t.favorited!) {
      favoriteIcon.image = UIImage(named: "favorite_on")
    }
    if (t.retweeted!) {
      retweetIcon.image = UIImage(named: "retweet_on")
    }
  }


}
