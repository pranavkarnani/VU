//
//  calVC.swift
//  VU
//
//  Created by Philip George on 25/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class calVC: UIViewController {
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.offwhite
        tv.backgroundColor = Colors.offwhite
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension calVC : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendar.data[0].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! calTVC
        cell.backgroundColor = Colors.offwhite
        let startcount = calendar.data[0].data[indexPath.row].startDate.count
        cell.day.text = String(calendar.data[0].data[indexPath.row].startDate.dropLast(startcount-2))
        cell.month_year.text = String(calendar.data[0].data[indexPath.row].startDate.dropFirst(3))
        cell.event.text = String(calendar.data[0].data[indexPath.row].type)
        cell.till.text = calendar.data[0].data[indexPath.row].endDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 114
    }

}

