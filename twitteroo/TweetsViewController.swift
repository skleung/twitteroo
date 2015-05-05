//
//  TweetsViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/23/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposeViewDelegate, TweetCellDelegate {
  
    var tweets: [Tweet]? = []
    @IBOutlet var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var replyId:Int? = 0
    var replyScreename:String? = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        onRefresh()
        // adds refresh control
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
      
        // set white color of navbar
        var nav = navigationController
        nav?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func onRefresh() {
      TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: { (tweets, error) -> () in
        if (error == nil) {
          self.tweets = tweets
          self.tableView.reloadData()
        } else {
          println(error)
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        self.refreshControl.endRefreshing()
      })
    }
  
    func addNewTweet(tweet: Tweet) {
      tweets?.insert(tweet, atIndex: 0)
      self.tableView.reloadData()
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None;
      cell.setupCell(tweets![indexPath.row])
      cell.delegate = self
      return cell
    }
  

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
    }
  
    func tapCell(cell: TweetCell) {
      replyId = cell.tweet?.id
      replyScreename = cell.tweet?.user?.screenname
      performSegueWithIdentifier("compose_segue", sender: nil)
    }
  
  func tapProfile(cell: TweetCell) {
    performSegueWithIdentifier("profile_segue", sender: cell)
  }
  
  
    @IBAction func onLogout(sender: AnyObject) {
      User.currentUser?.logout()
    }
      /*
      // MARK: - Navigation
      */
      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "compose_segue") {
          var composeVC = segue.destinationViewController as! ComposeViewController
          composeVC.delegate = self
          composeVC.replyId = replyId
          composeVC.replyScreenname = replyScreename
        }
        if (segue.identifier == "tweet_detail_segue") {
          var tweetDetailVC = segue.destinationViewController as! TweetDetailsViewController
          var cell = sender as! TweetCell
          var indexPath = tableView.indexPathForCell(cell)
          tweetDetailVC.tweet = tweets![indexPath!.row]
          
        }
        if (segue.identifier == "profile_segue") {
          var profileVC = segue.destinationViewController as! ProfileViewController
          var cell = sender as! TweetCell
          profileVC.user = cell.tweet!.user
          
        }
      }


}
