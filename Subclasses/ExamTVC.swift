//
//  ExamTVC.swift
//  VU
//
//  Created by Pranav Karnani on 18/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class ExamTVC: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var coursecode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
