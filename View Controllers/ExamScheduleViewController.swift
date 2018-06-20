//
//  ExamScheduleViewController.swift
//  VU
//
//  Created by Pranav Karnani on 18/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class ExamScheduleViewController: UIViewController {


    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        let query = sender.selectedSegmentIndex
        examScheduleDetails.data.removeAll()
        print(query)
        if query == 0 {
            DataHandler_fresh.shared.retrieveExamSchedule(type: "CAT1", completion: { (status) in
                if status == 0 {
                    
                    self.examTable.reloadData()
                }
            })
        }
        else if query == 1 {
            DataHandler_fresh.shared.retrieveExamSchedule(type: "CAT2", completion: { (status) in
                if status == 0 {
                    self.examTable.reloadData()
                }
            })
        }
        else {
            DataHandler_fresh.shared.retrieveExamSchedule(type: "FAT", completion: { (status) in
                if status == 0 {
                    self.examTable.reloadData()
                }
            })
        }
    }
    
    @IBOutlet weak var examMode: UISegmentedControl!
    
    @IBOutlet weak var slot: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var faculty: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseCode: UILabel!
    @IBOutlet weak var agenda: UILabel!
    @IBOutlet weak var masterCard: UIView!
    @IBOutlet weak var masterCardHeight: NSLayoutConstraint!
    @IBOutlet weak var examTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMasterCard()
        examTable.dataSource = self
        examTable.delegate = self

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
    }
    
    override func viewDidLayoutSubviews() {
        masterCard.layer.cornerRadius = 10.0
        masterCard.layer.shadowRadius = 2.0
        masterCard.layer.shadowOpacity = 0.2
        masterCard.layer.shadowOffset = CGSize(width: -1, height: 1)
    }
    
    func setUpMasterCard() {
        var x = 0
        for item in examScheduleDetails.data {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            let today = Date()
            let todaysDate = formatter.string(from: today)
            if item.exam_Date == todaysDate {
                x = 1
                slot.text = item.slot
                location.text = item.seat_Location
                location.textColor = Colors.blue1
                venue.text = item.venue
                type.text = item.type
                courseCode.text = item.course_Code
                courseTitle.text = item.course_Title
                courseTitle.textColor = Colors.blue1
                faculty.text = String(describing : item.exam_Time.prefix(8))
                faculty.alpha = 0.6
                break
            }
            
        }
        
        if x == 0 {
            masterCardHeight.constant = CGFloat(70)
            courseTitle.alpha = 0
            courseCode.alpha = 0
            location.alpha = 0
            slot.alpha = 0
            venue.alpha = 0
            faculty.alpha = 0
            type.alpha = 0
            agenda.text = "No exams today!"
            agenda.alpha = 1
            agenda.font = UIFont(name: "Helvetica", size: 16.0)
        }
        else {
            masterCardHeight.constant = self.view.frame.height * 0.25
        }
        
    }
    
}

extension ExamScheduleViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examScheduleDetails.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExamTVC
        cell.coursecode.text = examScheduleDetails.data[indexPath.row].course_Code
        cell.courseTitle.text = examScheduleDetails.data[indexPath.row].course_Title
        cell.type.text = examScheduleDetails.data[indexPath.row].type
        cell.location.text = examScheduleDetails.data[indexPath.row].seat_Location
        cell.venue.text = examScheduleDetails.data[indexPath.row].venue
        cell.containerView.layer.cornerRadius = 8
        cell.date.text = String(describing : examScheduleDetails.data[indexPath.row].exam_Date.prefix(2))
        cell.time.text = String(describing : examScheduleDetails.data[indexPath.row].exam_Time.prefix(8))
        cell.courseTitle.textColor = Colors.blue1
        cell.containerView.layer.shadowOpacity = 0.3
        cell.containerView.layer.shadowRadius = 2.0
        cell.containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.month.text = String(describing : examScheduleDetails.data[indexPath.row].exam_Date.suffix(8))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
