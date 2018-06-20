//
//  DetailedAttendanceViewController.swift
//  VU
//
//  Created by Pranav Karnani on 18/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class DetailedAttendanceViewController: UIViewController {
    
    
    var didAnimate = 0
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    let shapelayer = CAShapeLayer()
    var classNumber : String = ""
    var percentage : Int = 0
    var attendedClasses : Int = 0
    var totalClasses : Int = 0
    var acount = 0
    var mcount = 0
    var angleDiff : CGFloat = 0.0
    
    @IBAction func missDecrementTapped(_ sender: Any) {
        if mcount > 0 {
            mcount = mcount - 1
            totalClasses = totalClasses - 1
            setUpProgressBar()
        }
    }
    @IBAction func missIncrementTapped(_ sender: Any) {
        mcount = mcount + 1
        totalClasses = totalClasses + 1
        setUpProgressBar()
    }
    @IBAction func attendDecrementTapped(_ sender: Any) {
        if acount > 0
        {
            acount = acount - 1
            totalClasses = totalClasses - 1
            attendedClasses = attendedClasses - 1
            setUpProgressBar()
        }
    }
    @IBAction func attendIncrementTapped(_ sender: Any) {
        acount = acount + 1
        totalClasses = totalClasses + 1
        attendedClasses = attendedClasses + 1
        setUpProgressBar()
    }
    
    @IBOutlet weak var missDecrement: UIButton!
    @IBOutlet weak var missed: UILabel!
    @IBOutlet weak var missIncrement: UIButton!
    @IBOutlet weak var attendDecrement: UIButton!
    @IBOutlet weak var attended: UILabel!
    @IBOutlet weak var attendIncrement: UIButton!
    @IBOutlet weak var progressChart: UIView!
    @IBOutlet weak var progressBar: UILabel!
    @IBOutlet weak var slot: UILabel!
    @IBOutlet weak var faculty: UILabel!
    @IBOutlet weak var coursecode: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var detailedTable: UITableView!
    @IBOutlet weak var masterCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedTable.dataSource = self
        detailedTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
        setupMasterCard()
    
    }
    
    override func viewDidLayoutSubviews() {
        self.progressBar.layer.cornerRadius = self.progressBar.frame.width/2
        self.progressBar.layer.backgroundColor = UIColor.white.cgColor
        
        
        masterCard.layer.cornerRadius = 8.0
        masterCard.layer.shadowRadius = 2.0
        masterCard.layer.shadowOpacity = 0.2
        masterCard.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        detailedTable.layer.cornerRadius = 8.0
        detailedTable.layer.shadowRadius = 2.0
        detailedTable.layer.shadowOpacity = 0.2
        detailedTable.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        missIncrement.layer.cornerRadius = missIncrement.frame.size.width/2
        missDecrement.layer.cornerRadius = missDecrement.frame.size.width/2
        attendIncrement.layer.cornerRadius = attendIncrement.frame.size.width/2
        attendDecrement.layer.cornerRadius = attendDecrement.frame.size.width/2
    }
    
    func setupMasterCard() {
        for item in attendanceDet.data {
            if item.class_Nbr == classNumber {
                courseTitle.text = item.course_Title
                coursecode.text = item.course_Code
                slot.text = item.course_Type.contains("Theory") ? "Theory":"Lab"
                
                
                faculty.text = String(describing : item.faculty_Name.suffix(item.faculty_Name.count-5))
                percentage = Int(item.attendance_Percentage)!
                attendedClasses = Int(item.attended_Classes)!
                totalClasses = Int(item.total_Classes)!
                break
            }
        }
        
        setUpProgressBar()
        
    }
    
    func setUpProgressBar() {
        let height = progressChart.bounds.height
        let width = progressChart.bounds.width
        
        let center = CGPoint(x: width/2, y: height/2)
        
        if totalClasses > 0
        {
            percentage = Int(ceil((Double(attendedClasses*100)/Double(totalClasses))))
            progressLabel.text = "\(percentage)"
        }
        else
        {
            progressLabel.text = "nan"
        }
        progressBar.text = "\(attendedClasses) out of \(totalClasses)"
        attended.text = "\(acount)"
        missed.text = "\(mcount)"
        
        angleDiff = (2*CGFloat.pi/100.0)*CGFloat(self.percentage)
        
        var red : CGFloat
        var green : CGFloat
        var blue : CGFloat
        
        if (percentage < 75)
        {
            red = 220.0
            green = 100.0
            blue = 60.0
            
        }
        else if percentage >= 75 && percentage < 82
        {
            red = 100.0
            green = 190.0
            blue = 60.0
        }
        else
        {
            red = 60.0
            green = 100.0
            blue = 220.0
        }
        
        let path1 = UIBezierPath(arcCenter: center, radius: progressChart.frame.height/2.4, startAngle: -0.5*CGFloat.pi, endAngle: -0.5*CGFloat.pi+CGFloat(angleDiff), clockwise: true)
        
        
        
        shapelayer.path = path1.cgPath
        shapelayer.fillColor = UIColor.white.cgColor
        shapelayer.strokeColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        shapelayer.lineWidth = 7
        shapelayer.lineCap = kCALineCapRound
        shapelayer.strokeEnd = 0
        progressChart.layer.addSublayer(shapelayer)
        if didAnimate == 0 {
            animate()
        }
    }
    
    func animate() {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            animation.duration = 1
            
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            
            animation.toValue = 1
            shapelayer.add(animation, forKey: "circular")
            didAnimate = 1
        
    }
    
    func getDay(dayAndTime : String) -> String {
        
        
        if dayAndTime.contains("MON") {
            return "Monday"
        }
        else if dayAndTime.contains("TUE") {
            return "Tuesday"
        }
        else if dayAndTime.contains("WED") {
            return "Wednesday"
        }
        else if dayAndTime.contains("THU") {
            return "Thursday"
        }
        else if dayAndTime.contains("FRI") {
            return "Friday"
        }
        else {
            return "Monday"
        }
        
    }
    
}

extension DetailedAttendanceViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyStructure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailedAttendanceTableViewCell
        cell.serialNumber.text = dailyStructure[indexPath.row].serial_No
        cell.date.text = dailyStructure[indexPath.row].attendance_Date
        cell.day.text = getDay(dayAndTime: dailyStructure[indexPath.row].day_and_Timing)
        cell.status.image = UIImage(named : dailyStructure[indexPath.row].attendance_Status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 35
    }
}
