//
//  ContainerViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  var menuRevealed: Bool! = false
  
    var tweetsViewController: TweetsViewController!
//    var menuViewController: SideMenuViewController!
    var profileViewController: ProfileViewController!
    var timelineTabController: UITabBarController!
    var profileNavController: UINavigationController!
    var mentionsNavController: UINavigationController!
  
    var currentNavController: UINavigationController!
    
    @IBOutlet var containerView: UIView!
    var currentNavControllerOriginalCenter: CGPoint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // initialize first view to be the timeline
//      addChildViewController(timelineTabController)
//      timelineTabController.view.frame = containerView.frame
//      containerView.addSubview(timelineTabController.view)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  var contentViewController: UIViewController? {
    didSet {
      contentViewController!.view.frame = containerView.bounds
      for subview in containerView.subviews {
        subview.removeFromSuperview()
      }
      containerView.addSubview(contentViewController!.view)
      
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        self.containerView.frame.origin = CGPoint(x: 0, y:0)
      })
    }
  }
  
  var menuViewController: UIViewController? {
    didSet {
      menuViewController!.view.frame = containerView.bounds
      for subview in containerView.subviews {
        subview.removeFromSuperview()
      }
      containerView.addSubview(menuViewController!.view)
      
    }
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
      self.containerView!.frame.origin.x = self.menuViewController!.view.frame.width - 60
    })
  }
  
  func hideMenu() {
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.containerView!.frame.origin.x = 0
    })
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
