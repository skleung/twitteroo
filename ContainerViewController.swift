//
//  ContainerViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, SideMenuViewControllerDelegate {
  var menuRevealed: Bool! = false
  
    var tweetsViewController: TweetsViewController!
    var menuViewController: SideMenuViewController!
    var profileViewController: ProfileViewController!
    var timelineTabController: UITabBarController!
    var profileNavController: UINavigationController!
    var mentionsNavController: UINavigationController!
  
    var currentNavController: UINavigationController!
    
    @IBOutlet var containerView: UIView!
    var currentNavControllerOriginalCenter: CGPoint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("SideMenu") as! SideMenuViewController
        menuViewController.delegate = self
        
        timelineTabController = storyboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
        tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
      
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileViewController.user = User.currentUser!
      
        // initialize first view to be the timeline
      addChildViewController(timelineTabController)
      timelineTabController.view.frame = containerView.frame
      containerView.addSubview(timelineTabController.view)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
    if (sender.direction == .Right && sender.state == .Ended) {
      self.revealMenu()
    }
    if (sender.direction == .Left && sender.state == .Ended) {
      self.hideMenu()
    }
  }
  
  func revealMenu() {
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.containerView.frame.origin.x = self.menuViewController.view.frame.width
    })
  }
  
  func hideMenu() {
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.containerView.frame.origin.x = 0
    })
  }
  
  func didSelectHomeTimeline() {
    
  }
  
  func didSelectMenu() {
    // Go to the profile view
    println("WHTF")
    addChildViewController(menuViewController)
    menuViewController.view.frame = containerView.frame
    containerView.addSubview(menuViewController.view)
  }
  
  func didSelectProfile() {
    // go to profile
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
