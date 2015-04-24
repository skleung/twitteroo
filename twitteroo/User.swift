//
//  User.swift
//  twitteroo
//
//  Created by Sherman Leung on 4/22/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
  var name: String?
  var screenname: String?
  var profileImageUrl: String?
  var tagline: String?
  // we keep around this dictionary because the JSON is serializable and we don't need to encode it to store the current user in persistence
  var details: NSDictionary
  
  // constructor
  init(details: NSDictionary) {
    name = details["name"] as? String
    screenname = details["screen_name"] as? String
    profileImageUrl = details["profile_image_url"] as? String
    tagline = details["description"] as? String
    self.details = details
  }
  func logout() {
    User.currentUser = nil
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    
    // fires a global notification on logout
    NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
  }
  // gives global notion of user anytime
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
            var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
            _currentUser = User(details: dictionary)
        }
      }
      return _currentUser
    }
    set(user) {
      _currentUser = user
      if _currentUser != nil {
        var data = NSJSONSerialization.dataWithJSONObject(user!.details, options: nil, error: nil)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
      } else {
        // flushes it out
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
      }
      NSUserDefaults.standardUserDefaults().synchronize()

    }
  }
}
