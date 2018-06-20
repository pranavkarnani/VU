//
//  DashboardViewController.swift
//  VU
//
//  Created by Pranav Karnani on 09/03/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var didAnimate = 0
    var percentage : Int = 0
    var total_attend = 0
    var total = 0
    var upcoming : [TimetableBaseStructure] = []
    var done : [TimetableBaseStructure] = []
    let shapelayer = CAShapeLayer()
    var attendedClasses : Int = 0
    var acount = 0
    var mcount = 0
    var angleDiff : CGFloat = 0.0
    
    @IBAction func missDecrementTapped(_ sender: Any) {
        if mcount > 0 {
            mcount = mcount - 1
            total = total - 1
            setUpProgressBar()
        }
    }
    @IBAction func missIncrementTapped(_ sender: Any) {
        mcount = mcount + 1
        total = total + 1
        setUpProgressBar()
    }
    @IBAction func attendDecrementTapped(_ sender: Any) {
        if acount > 0
        {
            acount = acount - 1
            total = total - 1
            attendedClasses = attendedClasses - 1
            setUpProgressBar()
        }
    }
    @IBAction func attendIncrementTapped(_ sender: Any) {
        acount = acount + 1
        total = total + 1
        attendedClasses = attendedClasses + 1
        setUpProgressBar()
    }
    
    
    @IBOutlet weak var masterCardHeight: NSLayoutConstraint!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var missDecrement: UIButton!
    @IBOutlet weak var missCount: UILabel!
    @IBOutlet weak var missIncrement: UIButton!
    @IBOutlet weak var attendedCount: UILabel!
    @IBOutlet weak var attendDecrement: UIButton!
    @IBOutlet weak var attendIncrement: UIButton!
    @IBOutlet weak var attendancePercentage: UILabel!
    @IBOutlet weak var attendanceStats: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var doneTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var slotDetails: UILabel!
    @IBOutlet weak var facultyName: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var classStatus: UILabel!
    @IBOutlet weak var todayDate: UILabel!

    @IBOutlet weak var masterCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initaliseData()
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.dataSource = self
        upcomingTableView.isUserInteractionEnabled = false
        doneTableView.isUserInteractionEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        
        masterCard.layer.cornerRadius = 20.0
        masterCard.layer.shadowOpacity = 0.2
        masterCard.layer.shadowRadius = 1.0
        masterCard.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        
        attendIncrement = makeButton(button: attendIncrement)
        attendDecrement = makeButton(button: attendDecrement)
        missDecrement = makeButton(button: missDecrement)
        missIncrement = makeButton(button: missIncrement)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
        
        if done.count == 0
        {
            doneTableViewHeight.constant = 0
            doneTableView.alpha = 0
            doneLabel.alpha = 0.0
        }
        else if done.count > 0
        {
            doneTableViewHeight.constant = CGFloat(done.count * 100)
            doneTableView.alpha = 1
            doneLabel.alpha = 1.0
        }
        
        if upcoming.count <= 1 {
            upcomingTableViewHeight.constant = 0
            upcomingTableView.alpha = 0
            upcomingLabel.alpha = 0
            
        }
        
        if upcoming.count == 0 {
            masterCard.clipsToBounds = true
            masterCardHeight.constant = 40
            courseTitle.alpha = 0
            facultyName.alpha = 0
            slotDetails.alpha = 0
            progressView.alpha = 0
            venue.alpha = 0
            arrow.alpha = 0
            progressView.alpha = 0
            attendedCount.alpha = 0
            missCount.alpha = 0
            attendDecrement.alpha = 0
            attendIncrement.alpha = 0
            missIncrement.alpha = 0
            missDecrement.alpha = 0
            attendancePercentage.alpha = 0
            
            
            classStatus.text = "Done for the day"
        }
        
        else if upcoming.count > 1 {
            upcomingTableViewHeight.constant = CGFloat((upcoming.count * 100)-100)
            
        }
        
        doneTableView.reloadData()
        upcomingTableView.reloadData()
        initaliseData()
    }
    
    func initaliseData() {
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        let display = formatter.string(from: currentDate)
        todayDate.text = display
        formatter.dateFormat = "E"
        var day = formatter.string(from: currentDate as Date)
        
        
        switch day {
        case "Mon":
            day = "Monday"
            break
        case "Tue":
            day = "Tuesday"
            break
        case "Wed":
            day = "Wednesday"
            break
        case "Thu":
            day = "Thursday"
            break
        case "Fri":
            day = "Friday"
            break
        case "Sat":
            day = "Saturday"
            break
        case "Sun":
            day = "Sunday"
            break
        default:
            break
        }
        
        DataHandler_fresh.shared.retrieveTimetable(day: day) { (fetchStatus) in
            if fetchStatus == 0 {
                formatter.dateFormat = "HH:mm"
                let hour = formatter.string(from: currentDate as Date)
                for item in timetableForToday {
                    if item.start_Time > hour {
                        self.upcoming.append(item)
                    }
                    else {
                        self.done.append(item)
                    }
                }
                self.getStats()
            }
        }
        
    }
    
    func getStats()
    {
        if upcoming.count > 0 {
        upcoming[0].course_Type = upcoming[0].course_Type.replacingOccurrences(of: "E", with: "Embedded ")
        upcoming[0].course_Type = upcoming[0].course_Type.replacingOccurrences(of: "TH", with: "Theory")
        upcoming[0].course_Type = upcoming[0].course_Type.replacingOccurrences(of: "LA", with: "Lab")
        upcoming[0].course_Type = upcoming[0].course_Type.replacingOccurrences(of: "SS", with: "Soft Skill")
        
        if upcoming[0].course_Type == "Theory" {
            upcoming[0].course_Type = upcoming[0].course_Type + " Only"
        }
        else if upcoming[0].course_Type == "Lab" {
            upcoming[0].course_Type = upcoming[0].course_Type + " Only"
        }
        
        slotDetails.text = upcoming[0].slot
        venue.text = upcoming[0].venue
        if upcoming.count > 0 {
            for item in attendanceDet.data
            {
                if item.course_Code == upcoming[0].course_Code && item.course_Type == upcoming[0].course_Type
                {
                    courseTitle.text = item.course_Title
                    facultyName.text = String(describing : item.faculty_Name.suffix(item.faculty_Name.count-5)) + " | "
                    percentage = Int(item.attendance_Percentage)!
                    print(percentage)
                    total_attend = Int(item.attended_Classes)!
                    total = Int(item.total_Classes)!
                    setUpProgressBar()
                    break
                }
            }
        }
        }
    }
    
    
    
    
    
    func makeButton( button : UIButton) -> UIButton {
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 1.0
        button.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        button.layer.cornerRadius = button.frame.size.height/2
        return button
    }
    
    func setUpProgressBar() {
        
        let height = progressView.bounds.height
        let width = progressView.bounds.width
        
        let center = CGPoint(x: width/2, y: height/2)
        
        if total > 0
        {
            attendancePercentage.text = "\(percentage)"
        }
        else
        {
            attendancePercentage.text = "nan"
        }
        
        attendanceStats.text = "\(attendedClasses) out of \(total)"
        attendedCount.text = "\(acount)"
        missCount.text = "\(mcount)"
        
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
        
        let path1 = UIBezierPath(arcCenter: center, radius: progressView.frame.height/2.4, startAngle: -0.5*CGFloat.pi, endAngle: -0.5*CGFloat.pi+CGFloat(angleDiff), clockwise: true)
        
        
        
        shapelayer.path = path1.cgPath
        shapelayer.fillColor = UIColor.white.cgColor
        shapelayer.strokeColor = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        shapelayer.lineWidth = 7
        shapelayer.lineCap = kCALineCapRound
        shapelayer.strokeEnd = 0
        progressView.layer.addSublayer(shapelayer)
        
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
    
}


extension DashboardViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.upcomingTableView {
            return upcoming.count - 1
        }
        else {
            return done.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.upcomingTableView {
            
            let venueParsedU = upcoming[indexPath.row+1].venue
            let building = venueParsedU.components(separatedBy: NSCharacterSet.decimalDigits).joined()
            let room = venueParsedU.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined()
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingcell", for : indexPath) as! DashboardTVC
            cell.card.layer.cornerRadius = 10.0
            cell.card.layer.shadowOpacity = 0.2
            cell.card.layer.shadowRadius = 1.0
            cell.card.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
            
            let startTimeTBP = upcoming[indexPath.row+1].start_Time
            let hours = String(describing :startTimeTBP.prefix(2))
            let minutes = String(describing :startTimeTBP.suffix(2))
            var h = Int(hours)!
            if h >= 13
            {
                h=h-12
                cell.ampmLabel.text = "PM"
            }
            
            cell.timeLabel.text = String(h)
            cell.minutesLabel.text = minutes
            
            cell.codeLabel.text = upcoming[indexPath.row+1].course_Code + " | " + upcoming[indexPath.row+1].course_Type
            
            let str = building + room
            let build = str.suffix(3)
            let roomno = str.prefix(str.count-3)
            cell.locationLabel.text = roomno + "\n" + build

            print("!!!")
            for cluster in attendanceDet.data {
                
                print(cluster.slot)
                if cluster.slot.contains(upcoming[indexPath.row].slot) && upcoming[indexPath.row].course_Code == cluster.course_Code {
                    cell.nameLabel.text = cluster.course_Title
                    cell.attendanceLabel.text = String(cluster.attendance_Percentage)+"%"
                    if Int(cluster.attendance_Percentage)! > 80 {
                        cell.attendanceLabel.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                        break
                    }
                    else if Int(cluster.attendance_Percentage)! > 74 {
                        cell.attendanceLabel.textColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 36.0/255.0, alpha:1.0)
                        break
                    }
                    else{
                        cell.attendanceLabel.textColor = UIColor(red: 241.0/255.0, green: 57.0/255.0, blue: 57.0/255.0, alpha:1.0)
                        break
                    }
                }
                
                else if upcoming[indexPath.row].course_Type == "TH" && upcoming[indexPath.row].course_Code == cluster.course_Code {
                    cell.nameLabel.text = cluster.course_Title
                    cell.attendanceLabel.text = String(cluster.attendance_Percentage)+"%"
                    if Int(cluster.attendance_Percentage)! > 80 {
                        cell.attendanceLabel.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                        break
                    }
                    else if Int(cluster.attendance_Percentage)! > 74 {
                        cell.attendanceLabel.textColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 36.0/255.0, alpha:1.0)
                        break
                    }
                    else{
                        cell.attendanceLabel.textColor = UIColor(red: 241.0/255.0, green: 57.0/255.0, blue: 57.0/255.0, alpha:1.0)
                        break
                    }
                }
                
            }
            
            return cell
        }
            
        else {
            
            let venueParsedU = done[indexPath.row].venue
            let building = venueParsedU.components(separatedBy: NSCharacterSet.decimalDigits).joined()
            let room = venueParsedU.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined()
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "donecell", for: indexPath) as! DashboardTVC
            cell.card.layer.cornerRadius = 10.0
            cell.card.layer.shadowOpacity = 0.2
            cell.card.layer.shadowRadius = 1.0
            cell.card.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
            
            let startTimeTBP = done[indexPath.row].start_Time
            
            let hours = String(describing :startTimeTBP.prefix(2))
            let minutes = String(describing :startTimeTBP.suffix(2))
            var h = Int(hours)!
            if h >= 13
            {
                h=h-12
                cell.ampmLabel.text = "PM"
            }
            
            cell.timeLabel.text = String(h)
            cell.minutesLabel.text = minutes
            
            
            cell.codeLabel.text = done[indexPath.row].course_Code + " | " + done[indexPath.row].course_Type
            
            let str = building + room
            let roomno = str.suffix(3)
            let build = str.prefix(str.count-3)
            cell.locationLabel.text = build + "\n" + roomno
            
            for cluster in attendanceDet.data {
                if cluster.slot.contains(done[indexPath.row].slot) && done[indexPath.row].course_Code == cluster.course_Code {
                    cell.nameLabel.text = cluster.course_Title
                    cell.attendanceLabel.text = String(cluster.attendance_Percentage)+"%"
                    if Int(cluster.attendance_Percentage)! > 80 {
                        cell.attendanceLabel.textColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                        break
                    }
                    else if Int(cluster.attendance_Percentage)! > 74 {
                        cell.attendanceLabel.textColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 36.0/255.0, alpha:1.0)
                        break
                    }
                    else{
                        cell.attendanceLabel.textColor = UIColor(red: 241.0/255.0, green: 57.0/255.0, blue: 57.0/255.0, alpha:1.0)
                        break
                    }
                }
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
