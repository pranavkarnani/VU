//
//  BaseURLS.swift
//  VU
//
//  Created by Pranav Karnani on 11/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import Foundation

let base_URL = "http://vu2.adgvit.com"
let attendanceURL = base_URL + "/attendance/\(details.register_number)"
let loginURL = base_URL + "/login"
let profileURL = base_URL + "/profile/\(details.register_number)"
let examScheduleURL = base_URL + "/exam/\(details.register_number)"
var detailedAttendanceURL = base_URL + "/attendance/details/\(details.register_number)?slot="
let historyURL = base_URL + "/history/\(details.register_number)"
let timetableURL = base_URL + "/timetable/\(details.register_number)"
let proctorURL = base_URL + "/proctor/\(details.register_number)"
let markURL = base_URL + "/marks/\(details.register_number)"
var calendarURL = base_URL + "/calendar"
let facultyURL = base_URL + "/faculty"
