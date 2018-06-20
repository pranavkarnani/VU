//
//  FacultyViewController.swift
//  VU
//
//  Created by Pranav Karnani on 10/03/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var indexTapped = 2
    @IBOutlet weak var facultyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        facultyTableView.delegate = self
        facultyTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Colors.offwhite
        facultyTableView.backgroundColor = Colors.offwhite
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facultyList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath) as! FacultyTableViewCell
        cell.backgroundColor = Colors.offwhite
        cell.facultyName.text = facultyList.data[indexPath.row].name
        cell.facultyDesignation.text = facultyList.data[indexPath.row].designation
        cell.academicBlock.text = String(describing : facultyList.data[indexPath.row].venue.prefix(facultyList.data[indexPath.row].venue.count-4))
        cell.roomNo.text = String(describing : facultyList.data[indexPath.row].venue.suffix(3))
        cell.intercom.text = facultyList.data[indexPath.row].intercom
        cell.mail.text = facultyList.data[indexPath.row].mail
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexTapped == indexPath.row {
            return 130
        }
        else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexTapped = indexPath.row
        facultyTableView.reloadData()
        facultyTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
