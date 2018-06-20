////
////  AttendanceTVC.swift
////  VU
////
////  Created by Pranav Karnani on 26/01/18.
////  Copyright © 2018 Rishabh Mittal. All rights reserved.
////
//
import UIKit

class AttendanceTVC: UITableViewCell {
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coursecode: UILabel!
    @IBOutlet weak var faculty: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var attendancepercentageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

