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
  
  
    @IBOutlet var menuView: UIView!
    @IBOutlet var containerView: UIView!
    var currentNavControllerOriginalCenter: CGPoint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // initialize first view to be the timeline
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var tabBarViewController = storyboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
    
    var menu = storyboard.instantiateViewControllerWithIdentifier("SideMenu") as! SideMenuViewController
    
    menuViewController = menu
    contentViewController = tabBarViewController
    
  }
  
  var contentViewController: UIViewController? {
    didSet {
      if (containerView != nil) {
        addContentView()
      }
    }
  }
  
  func addContentView() {
    contentViewController!.view.frame = containerView.bounds
    for subview in containerView.subviews {
      subview.removeFromSuperview()
    }
    containerView.addSubview(contentViewController!.view)
    
    UIView.animateWithDuration(0.3, animations: { () -> Void in
      self.containerView.frame.origin = CGPoint(x: 0, y:0)
    })
  }
  
  var menuViewController: UIViewController? {
    didSet {
      if (menuView != nil) {
        addMenu()
      }
    }
  }
  
  func addMenu() {
    menuViewController!.view.frame = menuView.bounds
    for subview in menuView.subviews {
      subview.removeFromSuperview()
    }
    menuView.addSubview(menuViewController!.view)
  }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

  @IBAction func onContainerViewGesture(sender: UIPanGestureRecognizer) {
    var translation = sender.translationInView(view)
    var velocity = sender.velocityInView(view)
    
    if sender.state == UIGestureRecognizerState.Began {
      println("Began!")
    } else if sender.state == UIGestureRecognizerState.Changed {
      containerView.frame.origin = CGPoint(x: translation.x, y: 0)
    } else if sender.state == UIGestureRecognizerState.Ended {
      if velocity.x > 0 {
        println("right")
        containerView.frame.origin = CGPoint(x: 300, y: 0)
      } else {
        println("left")
        containerView.frame.origin = CGPoint(x: 0, y: 0)
      }
    }  }
  
  @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
    var translation = sender.translationInView(view)
    var velocity = sender.velocityInView(view)
    
    if sender.state == UIGestureRecognizerState.Began {
      println("Began!")
    } else if sender.state == UIGestureRecognizerState.Changed {
      containerView.frame.origin = CGPoint(x: translation.x, y: 0)
    } else if sender.state == UIGestureRecognizerState.Ended {
      if velocity.x > 0 {
        println("right")
        containerView.frame.origin = CGPoint(x: 300, y: 0)
      } else {
        println("left")
        containerView.frame.origin = CGPoint(x: 0, y: 0)
      }
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
