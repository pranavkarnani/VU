//
//  ProctorViewController.swift
//  VU
//
//  Created by Pranav Karnani on 17/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class ProctorViewController: UIViewController {
    
    
    @IBOutlet weak var proctorImage: UIImageView!
    @IBOutlet weak var callButton: UIView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var proctorName: UILabel!
    @IBOutlet weak var proctorDesignation: UILabel!
    @IBOutlet weak var cabinLocation: UILabel!
    @IBOutlet weak var location: UIImageView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self
        view.backgroundColor = Colors.offwhite
        
        DataHandler_fresh.shared.retrieveProctor { (didRetrieve) in
            if didRetrieve == 0{
                self.updateViews()
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
    
    func makeCard(view:UIView)->UIView{
        view.layer.cornerRadius = 8
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        return view
    }
    
    func updateViews() {
        print(proctorData)
        proctorName.text = proctorData.data[0].faculty_Name
        proctorDesignation.text = proctorData.data[0].faculty_Designation
        phoneNumber.text = proctorData.data[0].faculty_Mobile_Number
        cabinLocation.text = proctorData.data[0].cabin
        emailID.text = proctorData.data[0].faculty_Email
        phoneIcon.image = #imageLiteral(resourceName: "call")
        emailIcon.image = #imageLiteral(resourceName: "email")
        location.image = #imageLiteral(resourceName: "LocationArrow")
        proctorImage.image = #imageLiteral(resourceName: "proctorprofile")

    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        print("calling \(phoneNumber)")
    }
    
    private func sendMail(emailID:String){
        
        if let url = URL(string: "mailto:\(emailID)") {
            UIApplication.shared.open(url)
        }
        print("mailing \(emailID)")
        
    }
    
    override func viewDidLayoutSubviews() {
        detailView = makeCard(view: detailView)
        proctorImage.layer.cornerRadius = self.proctorImage.frame.height/2
        proctorImage.clipsToBounds = true

    }
}

extension ProctorViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProctorTableViewCell
        cell.callButton.layer.backgroundColor = Colors.offwhite.cgColor
        cell.mailView.layer.backgroundColor = UIColor.red.cgColor
        cell.CallLabel.layer.backgroundColor = UIColor.green.cgColor
        cell.mailView = makeCard(view: cell.mailView)
        cell.CallLabel = makeCard(view: cell.CallLabel)
        cell.label.text = "Contact Proctor"
        if(phoneNumber.text == "N/A")
        {
            cell.CallLabel.backgroundColor = .gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let email = emailID.text!
        if email != "N/A"{
        let closeAction = UIContextualAction(style: .normal, title:  "\(email)", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.sendMail(emailID: self.emailID.text!)
            success(true)
        })
        closeAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [closeAction])
        }
        else{
            let closeAction = UIContextualAction(style: .normal, title:  "\(email)", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                success(true)
            })
            closeAction.backgroundColor = .gray
            
            return UISwipeActionsConfiguration(actions: [closeAction])
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let number = phoneNumber.text!
        if number != "N/A" {
            
            let modifyAction = UIContextualAction(style: .normal, title:  "\(number)", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                self.callNumber(phoneNumber: self.phoneNumber.text!)
                success(true)
            })
            modifyAction.backgroundColor = .green
            
            return UISwipeActionsConfiguration(actions: [modifyAction])
        }
        else {
            let modifyAction = UIContextualAction(style: .normal , title:  "\(number)", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                success(true)
            })
            modifyAction.backgroundColor = .gray
            
            return UISwipeActionsConfiguration(actions: [modifyAction])
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("touching")
        let cell = tableView.cellForRow(at: indexPath) as! ProctorTableViewCell

        
        UIView.animate(withDuration: 0.5, animations: {
            cell.CallLabel.transform = CGAffineTransform(translationX: -15, y: 0)
            cell.mailView.transform = CGAffineTransform(translationX: 15, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                cell.CallLabel.transform = CGAffineTransform(translationX: 3, y: 0)
                cell.mailView.transform = CGAffineTransform(translationX: -3, y: 0)
            }, completion: nil)
        }
           
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
