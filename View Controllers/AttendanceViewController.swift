//
//  AttendanceViewController.swift
//  VU
//
//  Created by Pranav Karnani on 15/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController {
    var indexTapped : Int = 0
    @IBOutlet weak var overallAttendancePercent: UILabel!
 
    @IBOutlet weak var attendanceTableVIew: UITableView!
    @IBOutlet weak var overallAttendanceView: UIView!
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.offwhite
        
        attendanceTableVIew.dataSource = self
        attendanceTableVIew.delegate = self
        
        calculateOVerallAttendance()
    
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.offwhite
        self.attendanceTableVIew.backgroundColor = Colors.offwhite
    }

    override func viewDidAppear(_ animated: Bool) {
        attendanceTableVIew.dataSource = self
        attendanceTableVIew.delegate = self
        
        

    }
    
    
    func calculateOVerallAttendance()
    {
    
        var sum = 0
        for item in attendanceDet.data {
            sum = sum + Int(item.attendance_Percentage)!
            
        }
    
        sum = sum/attendanceDet.data.count
        overallAttendancePercent.text = "\(sum)%"
    
        if sum > 80
        {
            overallAttendancePercent.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        }
        else if sum >= 75
        {
            overallAttendancePercent.textColor = UIColor.orange
        }
        else
        {
            overallAttendancePercent.textColor = UIColor.red
        }
    }
    
    override func viewDidLayoutSubviews() {        
        self.overallAttendanceView.layer.cornerRadius = 10
        self.overallAttendanceView.layer.shadowRadius = 1.0
        self.overallAttendanceView.layer.shadowOpacity = 0.2
        self.overallAttendanceView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
    
        self.attendanceTableVIew.layer.cornerRadius = 10
        self.attendanceTableVIew.layer.shadowRadius = 1.0
        self.attendanceTableVIew.layer.shadowOpacity = 0.2
        self.attendanceTableVIew.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDetailedView() {
        DataHandler_fresh.shared.retrieveDetailedAttendance(number: attendanceDet.data[indexTapped].class_Nbr, completion:{ (status) in
            
            if status == 0 {
                self.performSegue(withIdentifier: "detailedView", sender: Any?.self)
            }
            else {
                print("error")
            }
        })
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedView" {
            let vc = segue.destination as! DetailedAttendanceViewController
            vc.classNumber = attendanceDet.data[indexTapped].class_Nbr
        }
    }
}



extension AttendanceViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceDet.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! AttendanceTVC
        cell.attendancepercentageLabel.text = String(attendanceDet.data[indexPath.row].attendance_Percentage)
        
        let percentage = Int(attendanceDet.data[indexPath.row].attendance_Percentage)!
        cell.courseTitle.text = attendanceDet.data[indexPath.row].course_Title
        
        
        if percentage > 80
        {
            
            cell.attendancepercentageLabel.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha : 1.0)
            
            cell.courseTitle.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha : 1.0)
        }
        else if percentage >= 75
        {
            cell.attendancepercentageLabel.textColor = UIColor.orange
            
            cell.courseTitle.textColor = UIColor.orange
        }
        else
        {
            cell.attendancepercentageLabel.textColor = UIColor.red
            cell.courseTitle.textColor = UIColor.red
            
        }
        
        cell.faculty.text = attendanceDet.data[indexPath.row].course_Type
        cell.coursecode.text = attendanceDet.data[indexPath.row].course_Code
        cell.containerView.layer.cornerRadius = 5.0
        cell.containerView.layer.shadowRadius = 1.0
        cell.containerView.layer.shadowOpacity = 0.2
        cell.containerView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        
        return cell


    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexTapped = indexPath.row
        setUpDetailedView()
        
    }
    
    
}
