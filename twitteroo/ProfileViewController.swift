//
//  ProfileViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  // this is the user object to be displayed
  
  
  @IBOutlet var tableView: UITableView!
  var user: User!
  
  var tweets: [Tweet] = []
    override func viewDidLoad() {
      
      if (user == nil) {
        user = User.currentUser
      }
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      // fetch user timeline stuff
      TwitterClient.sharedInstance.fetchUserTimeline(user, callback: { (tweets, error) -> Void in
        if (error == nil) {
          self.tweets = tweets!
          self.tableView.reloadData()
        } else {
          println(error)
        }
       
      })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count + 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if (indexPath.row == 0) {
        var cell = tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! BannerCell
        cell.user = user
        cell.setUpCell()
        return cell
    }
    if (indexPath.row == 1) {
      var cell = tableView.dequeueReusableCellWithIdentifier("StatsCell", forIndexPath: indexPath) as! StatsCell
      cell.user = user
      cell.setUpCell()
      return cell
    }
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    cell.tweet = tweets[indexPath.row - 2]
    cell.setupCell(tweets[indexPath.row - 2])
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if (indexPath.row == 0) {
      return 200
    }
    if (indexPath.row == 1) {
      return 80
    } else {
      return 130
    }
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
