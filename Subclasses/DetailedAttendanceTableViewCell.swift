//
//  DetailedAttendanceTableViewCell.swift
//  VU
//
//  Created by Pranav Karnani on 18/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class DetailedAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var status: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
