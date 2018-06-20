//
//  BaseStrutures_fresh.swift
//  VU
//
//  Created by Pranav Karnani on 10/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import Foundation

struct UserDetails : Codable
{
    var register_number : String = "N/A"
    var password : String = "N/A"
}

var details = UserDetails()

var isLoggedIn : Bool = false

struct attendanceStructure : Decodable
{
    var serial_No : String
    var attendance_Percentage : String
    var attended_Classes:String
    var class_Nbr: String
    var course_Code : String
    var course_Title:String
    var course_Type: String
    var faculty_Name : String
    var slot : String
    var total_Classes: String
}

struct attendanceCluster : Decodable {
    var code : Int
    var message : String
    var data : [attendanceStructure]
}

struct detailedAttendanceStructure : Decodable {
    var serial_No : String
    var attendance_Date : String
    var attendance_Slot : String
    var day_and_Timing : String
    var attendance_Status : String
}

struct detailedAttendance : Decodable {
    var code : Int
    var message : String
    var data : [detailedAttendanceStructure]
}

var detailedAtt = detailedAttendance(code : 0,message : "", data : [])


var attendanceDet = attendanceCluster(code : 0,message : "", data : [])
var profile : Profile = Profile(code : 0,message : "", data : [])

struct Proctor : Decodable {
    var code : Int
    var message : String
    var data : [ProctorStructure]
}

struct ProctorStructure: Decodable
{
    var cabin : String?
    var faculty_Department: String?
    var faculty_Designation : String?
    var faculty_Email: String?
    var faculty_ID: String?
    var faculty_Mobile_Number: String?
    var faculty_Name: String?
    var faculty_Intercom: String?
    var school: String?
}

struct NetworkStatus : Decodable {
    var code : Int?
    var message : String?
}

struct ProfileStructure : Decodable {
    var student_Name : String
    var date_Of_Birth : String
    var gender : String
    var program : String
    var branch : String
    var school : String
    var mobile_Number : String
    var image_Data : String
}

struct Profile : Decodable {
    var code : Int
    var message : String
    var data : [ProfileStructure]
}

var proctorData = Proctor(code : 0,message : "",data : [])


struct History : Decodable {
    var code : Int
    var message : String
    var data : [HistoryStructure]
}

struct HistoryStructure : Decodable {
    var course_Code : String
    var course_Title : String
    var course_Type : String
    var credits : String
    var grade : String
    var exam_Month : String
    var result_Declared : String
    var node_Type : String
}

struct ExamSchedule : Decodable {
    var code : Int
    var message : String
    var data : [ExamScheduleStructure]
}

struct ExamScheduleStructure : Decodable {
    var serial_No : String
    var course_Code : String
    var course_Title : String
    var course_Type : String
    var class_ID : String
    var slot : String
    var exam_Date : String
    var exam_Session : String
    var exam_Time : String
    var venue : String
    var seat_Location : String
    var seat_Number : String
    var type : String
}

var historyDetails = History(code : 0, message : "", data: [])
var examScheduleDetails = ExamSchedule(code : 0, message : "", data: [])

struct DetailedAttendanceBase {
    var class_Nbr : String
    var details : [detailedAttendanceStructure]
}

struct TimetableBaseStructure : Decodable {
    var course_Code : String
    var course_Type : String
    var slot : String
    var venue : String
    var start_Time : String
    var end_Time : String
}

struct DayTimetable : Decodable {
    var Day : [TimetableBaseStructure]?
}

struct TimetableCluster : Decodable {
    var code : Int
    var message : String
    var data : [DayTimetable]
}

struct MarksCluster : Decodable {
    var code : Int
    var message : String
    var data : [SubjectDetails]
}


struct SubjectDetails : Decodable {
    var serial_No : String
    var course_Code : String
    var course_Title : String
    var course_Type : String
    var LTPJC : String
    var slot : String
    var data : [MarksStructure]
}

struct MarksStructure : Decodable {
    var mark_Title : String
    var max_mark : String
    var scored_Mark : String
    var weightage_Mark : String
    var average : String?
    var lowest : String?
    var highest : String?
    var count : String?
}

struct RetrievedMarks {
    var courseTitle : String
    var courseType : String
    var scored : String
    var max : String
    var avg : String
    var mTitle : String
    var weightage : String
    var count : String
    var highest : String
    
}

struct AcademicCalBase : Decodable {
    var code : Int
    var message : String
    var data : [AcademicCalender]
}

struct AcademicCalender : Decodable {
    var _id : String
    var title : String
    var data : [Description]
}

struct Description : Decodable {
    var type : String
    var startDate : String
    var endDate : String
}

struct FacultyBase : Decodable {
    var name : String
    var designation : String
    var venue : String
    var intercom : String
    var mail : String
    var imageData : String
}

struct Faculty : Decodable {
    var code : Int
    var message : String
    var data : [FacultyBase]
}

var facultyList = Faculty(code : 0,message : "" ,data : [])
var myMarks : [RetrievedMarks] = []
var marksData = MarksCluster(code: 0, message: "", data: [])
var detailedAttendanceData : [DetailedAttendanceBase] = []
var timetableCluster = TimetableCluster(code: 0, message: "", data: [])
var dailyStructure : [detailedAttendanceStructure] = []
var calendar = AcademicCalBase(code : 0,message : "",data : [])
var timetableForToday : [TimetableBaseStructure] = []
var statusCode : Int = 0
var timetable : [[TimetableBaseStructure]] = [[]]
