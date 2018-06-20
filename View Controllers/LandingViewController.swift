//
//  LandingViewController.swift
//  VU
//
//  Created by Pranav Karnani on 14/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
        
        DataHandler_fresh.shared.retrieveUserDetails { (status) in
            print(isLoggedIn)
            print(details.register_number)
            if isLoggedIn {
                DataHandler_fresh.shared.retrieveExamSchedule(type : "CAT1",completion: { (examStatus) in
                    if examStatus == 0 {
                        DataHandler_fresh.shared.retrieveAttendanceData(completion: { (attendanceStatus) in
                            if attendanceStatus == 0 {
                                DataHandler_fresh.shared.retrieveProctor(completion: { (proctorStatus) in
                                    if proctorStatus == 0 {
                                        DataHandler_fresh.shared.retrieveProctor(completion: { (markStatus) in
                                            if markStatus == 0 {
                                                DataHandler_fresh.shared.retrieveTimetable(day: "Monday", completion: { (timetableRetrieved) in
                                                    if timetableRetrieved == 0 {
                                                        self.performSegue(withIdentifier: "loggedIn", sender: Any?.self)
                                                    }
                                                })
                                            }
                                            
                                        })
                                    }
                                    else {
                                        print("___")
                                    }
                                    
                                })
                            }
                            else {
                                print("____")
                            }
                            
                        })
                        
                    }
                    else {
                        print("____")
                    }
                })
                
            }
            else {
                
                print("____")
                self.performSegue(withIdentifier: "toLogin", sender: Any?.self)
            }
        }

    }
    
    
}





extension UIView {
    
    func setGradientBackground(colorOne : UIColor, colorTwo : UIColor)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.locations = [0.0,1.0]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}

