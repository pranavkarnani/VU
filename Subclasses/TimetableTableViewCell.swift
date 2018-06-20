//
//  TimetableTableViewCell.swift
//  VU
//
//  Created by Pranav Karnani on 25/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class TimetableTableViewCell: UITableViewCell {

    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var faculty: UILabel!
    @IBOutlet weak var slot: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
