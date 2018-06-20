//
//  HomeViewController.swift
//  VU
//
//  Created by Pranav Karnani on 14/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var timetable: UITableView!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var tomorrow: UILabel!
    
    let days : [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var index = 0

    override func viewDidLoad() {
        
        DataHandler_fresh.shared.retrieveTimetable(day: days[index]) { (stat) in
            if stat == 0 {
                self.timetable.reloadData()
                self.index = 1
            }
        }
        
        super.viewDidLoad()
        view.backgroundColor = Colors.offwhite
        timetable.backgroundColor = Colors.offwhite
        timetable.dataSource = self
        timetable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TimetableViewController.swipedRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swifeLeft = UISwipeGestureRecognizer(target: self, action: #selector(TimetableViewController.swipedLeft))
        swifeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swifeLeft)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableForToday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimetableTableViewCell
        cell.backgroundColor = Colors.offwhite
        cell.container.layer.cornerRadius = 5.0
        cell.courseCode.text = timetableForToday[indexPath.row].course_Code
        cell.startTime.text = timetableForToday[indexPath.row].start_Time
        cell.slot.text = timetableForToday[indexPath.row].slot
        cell.container = makeCard(view: cell.container)
        cell.venue.text = timetableForToday[indexPath.row].venue
        print(timetableForToday[indexPath.row].course_Type)
        for item in attendanceDet.data {
            print(item.course_Type)
            
            if item.course_Code == timetableForToday[indexPath.row].course_Code {
                cell.courseTitle.text = item.course_Title
                cell.faculty.text = String(describing : item.faculty_Name.suffix(item.faculty_Name.count-5))
                
                let attendance = Int(item.attendance_Percentage)!
                if attendance > 75 && attendance <= 82 {
                    cell.courseTitle.textColor = .orange
                }
                
                else if attendance < 75 {
                    cell.courseTitle.textColor = .red
                }
                
                else {
                    cell.courseTitle.textColor = Colors.blue1
                }
                
                continue
                
            }
        }
        return cell
    }
    
    @objc func swipedLeft() {
       // animateLeft()
        DataHandler_fresh.shared.retrieveTimetable(day: days[index]) { (fetched) in
            if fetched == 0 {
                self.animateLeft()
                self.timetable.reloadData()
            }
        }
        
    }
    
    @objc func swipedRight() {
        
      //  animateRight()
        DataHandler_fresh.shared.retrieveTimetable(day: days[index]) { (fetched) in
            if fetched == 0 {
                self.animateRight()
                self.timetable.reloadData()
            }
        }
    }
    
    func animateRight() {
        
        let todayTransform = self.tomorrow.transform
        self.tomorrow.alpha = 0.1
        
        let diff = self.tomorrow.frame.origin.x - self.today.frame.origin.x
        
        UIView.animate(withDuration: 0.6, animations: {
            self.today.transform = CGAffineTransform(translationX: diff, y: 0)
            
        }) { (true) in
            
            DispatchQueue.main.async {
                
                self.today.alpha = 0
                self.tomorrow.alpha = 0
                self.tomorrow.text = self.today.text
                
                self.index = self.index - 1
                if self.index == -1 {
                    self.index = 6
                }
                
                print(self.index)
                self.today.transform = todayTransform
                self.today.text = self.days[self.index]
                self.today.alpha = 1.0
                self.tomorrow.alpha = 0.46
            }
            
        }
        
    }
    
    func animateLeft() {
        
        let tomorrowTransform = self.tomorrow.transform
        self.today.alpha = 0.1
        let diff = self.today.frame.origin.x - self.tomorrow.frame.origin.x
    
        UIView.animate(withDuration: 0.6, animations: {
            self.tomorrow.transform = CGAffineTransform(translationX: diff, y: 0)
            
        }) { (true) in
            
            DispatchQueue.main.async {
                
                self.today.alpha = 0
                self.tomorrow.alpha = 0
                self.today.text = self.tomorrow.text
                
                self.index = self.index + 1
                if self.index == 7 {
                    self.index = 0
                }
                
                print(self.index)
                self.tomorrow.transform = tomorrowTransform
                self.tomorrow.text = self.days[self.index]
                self.today.alpha = 1.0
                self.tomorrow.alpha = 0.46
            }
            
        }
        
    }
    
    func makeCard(view:UIView)->UIView{
        view.layer.cornerRadius = 8
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        return view
    }
    
}
