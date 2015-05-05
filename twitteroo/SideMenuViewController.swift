//
//  SideMenuViewController.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

protocol SideMenuViewControllerDelegate {
  func didSelectProfile()
  func didSelectHomeTimeline()
}


class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var delegate: SideMenuViewControllerDelegate?
    var menuTitles = ["Timeline", "Your Mentions", "Logout"]
    var menuIcons = ["timer", "mentions", "logout"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      var cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileCell
      cell.user = User.currentUser
      return cell
    } else {
      var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuCell
      cell.menuLabel.text = menuTitles[indexPath.row+1]
      cell.menuIconImage.image = UIImage(named: menuIcons[indexPath.row+1])
      return cell
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
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
