//
//  Tweet.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/22/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var user: User?
  var text: String?
  var imageURL: String?
  var createdAtString: String?
  var createdAt: NSDate?
  var numFavorites: Int?
  var numRetweets: Int?
  var favorited: Bool?
  var retweeted: Bool?
  var id: Int?
  var replyText: String?
  var replyScreenname: String?
  var retweetText: String?
  
  init(details: NSDictionary) {
    println(details)
    user = User(details: details["user"] as! NSDictionary)
    text = details["text"] as? String    
    createdAtString = details["created_at"] as? String
    numFavorites = details["favorite_count"] as? Int
    numRetweets = details["retweet_count"] as? Int
    favorited = (details["favorited"] as! Int) == 1
    retweeted = (details["retweeted"] as! Int) == 1
    replyScreenname = details["in_reply_to_screen_name"] as? String
    if (replyScreenname != nil) {
      replyText = replyScreenname! + " replied"
    }
    if (details["retweeted_status"] != nil) {
      var originalTweet = Tweet(details: details["retweeted_status"] as! NSDictionary)
      retweetText = originalTweet.user!.screenname! + " retweeted"
    }
    id = details["id"] as? Int
    var formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtString!)
  }

  class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    for detail in array {
      tweets.append(Tweet(details: detail))
    }
    return tweets
  }
}