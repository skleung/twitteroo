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
  var createdAtString: String?
  var createdAt: NSDate?
  
  init(details: NSDictionary) {
    user = User(details: details["user"] as! NSDictionary)
    text = details["text"] as? String
    createdAtString = details["text"] as? String
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