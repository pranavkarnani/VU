//
//  FacultyTableViewCell.swift
//  VU
//
//  Created by Pranav Karnani on 10/03/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class FacultyTableViewCell: UITableViewCell {

    @IBOutlet weak var roomNo: UILabel!
    @IBOutlet weak var academicBlock: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var intercom: UILabel!
    @IBOutlet weak var facultyImage: UIImageView!
    @IBOutlet weak var facultyDesignation: UILabel!
    @IBOutlet weak var facultyName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
