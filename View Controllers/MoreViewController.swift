//
//  MoreViewController.swift
//  VU
//
//  Created by Aritro Paul on 20/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    var list : [String] = ["AcademicHistory","AttendanceData","Calendar","DetailedAttendance","ExamDetails","Marks","MyDetails","ProctorData","Timetable"]
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var registrationNumber: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.dataSource = self
        menuTable.delegate = self
        menuTable.backgroundColor = Colors.offwhite
        DataHandler_fresh.shared.retrieveUserDetails { (didRetrieve) in
            if didRetrieve == 0{
                self.updateView()
            }
            else{
                print("error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let menu = ["Grades","Calendar","Marks","Proctor","Services","Logout"]
    let menuSegues = ["","goToCalendar","","goToProctor","goToServices",""]
    let menuIcons = ["grades.png","calendar.png","marks.png","proctor.png","marks.png","proctor.png"]
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
    }
    
    func updateView(){
        let Name = profile.data[0].student_Name
        var nameArr = Name.components(separatedBy: " ")
        firstName.text = nameArr[0]
        lastName.text = nameArr[1]
        print(profile.data[0].image_Data.suffix(profile.data[0].image_Data.count-17))
        let data = Data(base64Encoded: String(describing : profile.data[0].image_Data.suffix(profile.data[0].image_Data.count-17)))
        profileImage.image = UIImage(data: data!)
        registrationNumber.text = details.register_number
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

}




extension MoreViewController:  UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MoreTableViewCell
        cell.viewName.text = menu[indexPath.row]
        cell.iconImage.image = UIImage(named: menuIcons[indexPath.row])
        cell.containerView.layer.shadowOpacity = 0.2
        cell.containerView.layer.shadowRadius = 3.0
        cell.containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.backgroundColor = Colors.offwhite
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if menu[index] == "Logout" {
            DataHandler_fresh.shared.delete(entities: self.list)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let landing = storyboard.instantiateViewController(withIdentifier: "first") as! LandingViewController
            UIApplication.shared.keyWindow?.rootViewController = landing
        }
        else if(menuSegues[indexPath.row]==""){
            
        }
        else{
        performSegue(withIdentifier: menuSegues[indexPath.row], sender: Any?.self)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
        
    }
    

}
