//
//  TwitterClient.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/22/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

let twitterConsumerSecret = "5osnxH9pXuqvCISRYHftpI4EAL15tQX82Avdh5zzmelF4RrdeV"
let twitterConsumerKey = "TSdpjPbg7IrJThcs74nXVxavE"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
  
  var loginCompletion: ((user: User?, error: NSError?) -> ())?
  class var sharedInstance: TwitterClient{
    struct Static {
      static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
      
    }
    return Static.instance
  }
  
  func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
    loginCompletion = completion
    
    // fetch request token and redirect to authorization page
    requestSerializer.removeAccessToken()
    fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"cptwitterdemo://oauth"), scope: "", success: { (requestToken: BDBOAuth1Credential!) -> Void in
      var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
      UIApplication.sharedApplication().openURL(authURL)
      
      }) { (error: NSError!) -> Void in
        self.loginCompletion?(user: nil, error: error)
      }
  }
  
  func openURL(url: NSURL) {
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken:BDBOAuth1Credential!) -> Void in
      //saves access token
      TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
      // grabs verification info
      TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        var user = User(details: response as! NSDictionary)
        User.currentUser = user
        self.loginCompletion?(user: user, error: nil)
        }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
          println("error getting current user")
          self.loginCompletion?(user: nil, error: error)
      })
      }) { (error:NSError!) -> Void in
        println("failed to receive access token")
        
    }
  }
  
  func homeTimelineWithCompletion(params:NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
    GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
        completion(tweets: tweets, error: nil)
      }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
        completion(tweets: nil, error: error)
    }
  }
  
  func createTweet(params: NSDictionary?, completion: (status: Tweet?, error: NSError?) -> ()) {
    self.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweet = Tweet(details: response as! NSDictionary)
      completion(status: tweet, error: nil)
      }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        println("error posting status update")
        completion(status: nil, error: error)
    }
  }
}
