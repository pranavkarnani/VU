//
//  ProctorTableViewCell.swift
//  VU
//
//  Created by Aritro Paul on 25/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class ProctorTableViewCell: UITableViewCell {

    @IBOutlet weak var CallLabel: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var callButton: UIView!
    @IBOutlet weak var calllabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
