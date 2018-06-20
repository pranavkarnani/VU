//
//  calTVC.swift
//  VU
//
//  Created by Philip George on 25/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class calTVC: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var month_year: UILabel!
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var till: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
