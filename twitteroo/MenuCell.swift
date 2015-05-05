//
//  MenuCell.swift
//  twitteroo
//
//  Created by Sherman Leung on 5/1/15.
//  Copyright (c) 2015 Sherman Leung. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

  @IBOutlet var menuLabel: UILabel!
  @IBOutlet var menuIconImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
