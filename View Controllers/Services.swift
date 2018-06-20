//
//  Services.swift
//  VU
//
//  Created by Philip George on 08/01/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//


import UIKit

class Services: UIViewController, UITableViewDataSource, UITableViewDelegate,UITabBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var names0:[String] = ["Health Center 1", "Health Center 2", "VIT University", "Indian Bank VIT Branch", "UG Admissions Office", "Finance Office", "Student Welfare", "Chief Warden (Men)", "Chief Warden (Ladies)", "Domino's Vellore"]
    var phones0:[String] = ["+914162202000", "+914162202217", "+914162243091", "+914162202157", "+914162240005", "+914162202259", "+914162202200", "+914162202127", "+914162202719", "+914162244445"]
    var emails0:[String] = ["", "", "info@vit.ac.in", "", "", "", "", "cw.mh@vit.ac.in", "cw.lh@vit.ac.in", ""]
    var images:[String] = ["ambulance","ambulance","university","indianBank","ug","finance","building","hostel", "logo", "dominos"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = Colors.offwhite
        view.backgroundColor = Colors.offwhite
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names0.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ServicesTableViewCell
        cell.backgroundColor = Colors.offwhite
        cell.Thumbnail.image = UIImage(named: images[(indexPath as NSIndexPath).row])
        cell.Thumbnail.layer.cornerRadius = cell.Thumbnail.frame.size.width/2
        cell.Thumbnail.layer.masksToBounds = true
        cell.Thumbnail.layer.opacity = 0.75
        
        cell.nameLabel.text = names0[(indexPath as NSIndexPath).row]
        cell.phoneLabel.text = phones0[(indexPath as NSIndexPath).row]
        cell.emailLabel.text = emails0[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let name = names0[indexPath.row]
        
        if name != ""{
            let closeAction = UIContextualAction(style: .normal, title: "Call \(name)", handler: { (ac, view, success:(Bool) -> Void) in
                UIApplication.shared.open(URL(string:"tel://"+"\(self.phones0[indexPath.row])")!)
                success(true)
            })
            closeAction.backgroundColor = .green
            
            return UISwipeActionsConfiguration(actions: [closeAction])
        }
            
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

