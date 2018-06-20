//
//  LoginViewController.swift
//  VU
//
//  Created by Pranav Karnani on 14/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var greeting4: UIImageView!
    @IBOutlet weak var greeting6: UIImageView!
    @IBOutlet weak var greeting5: UIImageView!
    @IBOutlet weak var greeting3: UIImageView!
    @IBOutlet weak var greeting2: UIImageView!
    @IBOutlet weak var greeting1: UIImageView!
    @IBOutlet weak var loginBttn: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var greetingsView: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registrationNumber: UITextField!
    
    @IBAction func loginBttnTapped(_ sender: Any) {
        DispatchQueue.main.async {
            if self.registrationNumber.text! == "" || self.password.text! == "" {
                self.showAlert(title : "Error", message : "One of the fields has been left blank")
            }
            else {
                details.register_number = self.registrationNumber.text!
                details.password = self.password.text!
                self.login()
                self.loginBttn.isUserInteractionEnabled = false
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        greetingsView.backgroundColor = UIColor.clear
        greetings()
    }
    
    func greetings() {
        if statusCode == 200 {
            self.welcome()
        }
        UIView.animate(withDuration: 1, animations: {
            self.greeting1.alpha = 0.2
        }) { (true) in
            if statusCode == 200 {
                self.welcome()
                return
            }
            UIView.animate(withDuration: 1, animations: {
                self.greeting2.alpha = 1.0
            }, completion: { (true) in
                if statusCode == 200 {
                    self.welcome()
                    return
                }
                UIView.animate(withDuration: 1, animations: {
                    self.greeting2.alpha = 0.2
                }, completion: { (true) in
                    if statusCode == 200 {
                        self.welcome()
                        return
                    }
                    UIView.animate(withDuration: 1, animations: {
                        self.greeting3.alpha = 1.0
                    }, completion: { (true) in
                        if statusCode == 200 {
                            self.welcome()
                            return
                        }
                        UIView.animate(withDuration: 1, animations: {
                            self.greeting3.alpha = 0.2
                        }, completion: { (true) in
                            if statusCode == 200 {
                                self.welcome()
                                return
                            }
                            UIView.animate(withDuration: 1, animations: {
                                self.greeting4.alpha = 1.0
                            }, completion: { (true) in
                                if statusCode == 200 {
                                    self.welcome()
                                    return
                                }
                                UIView.animate(withDuration: 1, animations: {
                                    self.greeting4.alpha = 0.2
                                }, completion: { (true) in
                                    if statusCode == 200 {
                                        self.welcome()
                                        return
                                    }
                                    UIView.animate(withDuration: 1, animations: {
                                        self.greeting5.alpha = 1.0
                                    }, completion: { (true) in
                                        if statusCode == 200 {
                                            self.welcome()
                                            return
                                        }
                                        UIView.animate(withDuration: 1, animations: {
                                            self.greeting5.alpha = 0.2
                                        }, completion: { (true) in
                                            if statusCode == 200 {
                                                self.welcome()
                                                return
                                            }
                                            UIView.animate(withDuration: 1, animations: {
                                                self.greeting6.alpha = 1.0
                                            }, completion: { (true) in
                                                if statusCode == 200 {
                                                    self.welcome()
                                                    return
                                                }
                                                UIView.animate(withDuration: 1, animations: {
                                                    self.greeting6.alpha = 0.2
                                                }, completion: { (true) in
                                                    if statusCode == 200 {
                                                        self.welcome()
                                                        return
                                                    }
                                                    UIView.animate(withDuration: 1, animations: {
                                                        self.greeting1.alpha = 1.0
                                                    }, completion: { (true) in
                                                        if statusCode == 200 {
                                                            self.welcome()
                                                            return
                                                        }
                                                        else {
                                                            self.greetings()
                                                        }
                                                    })
                                                })
                                            })
                                        })
                                    })
                                    
                                })
                            })
                        })
                        
                    })
                })
            })
            
        }
    }
    
    func welcome() {
        UIView.animate(withDuration: 1, animations: {
            self.greetingsView.alpha = 0.0
        }) { (true) in
            UIView.animate(withDuration: 1, animations: {
                self.bar.transform = CGAffineTransform(scaleX: self.baseView.frame.width/self.bar.frame.width, y: self.baseView.frame.height/self.bar.frame.height)
                self.bar.center.x = self.baseView.center.x
                self.bar.center.y = self.baseView.center.y
            }) { (true) in
                
                UIView.animate(withDuration: 1, animations: {
                    UIView.animate(withDuration: 2, animations: {
                        let label = UILabel()
                        label.text = "Hello, \(details.register_number)"
                        label.font = UIFont(name: "Helvetica", size: 32.0)
                        label.center.x = self.bar.center.x
                        label.center.y = self.bar.center.y
                        label.sizeToFit()
                        label.textColor = UIColor.white
                        self.bar.addSubview(label)
                        
                    }, completion: { (true) in
                        
                    })
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {

        loginView.layer.cornerRadius = 10.0
        loginView.layer.shadowRadius = 2.0
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 0.2
        loginView.layer.shadowOffset = CGSize(width: -1.0, height: 2.0)
        
        loginBttn.layer.cornerRadius = loginBttn.frame.height/2
    }
    
    func login() {
        DispatchQueue.main.async {
            
            RequestsHandler_fresh.shared.performLogin { (status) in
                
                if status == 0 {
                    self.performSegue(withIdentifier: "loginSuccessful", sender: Any?.self)
                }
                else {
                    self.showAlert(title: "Error", message: "Invalid credentials")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
        
    }
    
    func showAlert(title  :String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let bttn = UIAlertAction(title: "Done", style: .default, handler: nil)
        
        alert.addAction(bttn)
        present(alert, animated: true, completion: nil)
    }
}


