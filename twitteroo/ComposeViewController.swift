//
//  ComposeViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/26/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

protocol ComposeViewDelegate {
  func addNewTweet(tweet: Tweet);
}

class ComposeViewController: UIViewController, UITextViewDelegate {

  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var handleLabel: UILabel!
  @IBAction func cancelModal(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  @IBOutlet var textView: UITextView!
  @IBOutlet var photoView: UIImageView!
  @IBOutlet var charsLeftLabel: UILabel!
  var charsLeft = 140
  var replyId:Int? = 0
  var replyScreenname:String?
  var receivedTweet:Tweet?
  var delegate: ComposeViewDelegate?
  let TOTAL_TWEET_CHARS = 140
  
  @IBAction func onTweet(sender: AnyObject) {
    var params:NSMutableDictionary = NSMutableDictionary()
    params.setValue(textView.text, forKey: "status")
    if (replyId > 0) {
      params.setValue(replyId, forKey: "in_reply_to_status_id")
    }
    TwitterClient.sharedInstance.createTweet(params, completion: { (tweet, error) -> () in
      if (error == nil) {
        self.receivedTweet = tweet
        self.delegate?.addNewTweet(tweet!)
        self.dismissViewControllerAnimated(true, completion: nil)
      } else {
        println(error)
      }
    })
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(string: User.currentUser!.profileImageUrl!)
      if (replyScreenname != nil && replyScreenname != "") {
        textView.text = "@" + replyScreenname! + " "
      } else {
        textView.text = "What's happening?"
      }
        photoView.setImageWithURL(url!)
        nameLabel.text = User.currentUser?.name
        handleLabel.text = "@" + User.currentUser!.screenname!
        // Do any additional setup after loading the view.
        textView.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func textViewDidBeginEditing(textView: UITextView) {
    textView.text = ""
    if (replyScreenname != nil && replyScreenname != "") {
      textView.text = "@" + replyScreenname! + " "
    }
  }
  
    func textViewDidChange(textView: UITextView) {
      charsLeft = TOTAL_TWEET_CHARS - count(textView.text) ;
      charsLeftLabel.text = "\(charsLeft)"
      println(charsLeft)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
