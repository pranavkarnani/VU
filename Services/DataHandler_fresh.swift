//
//  DataHandler_fresh.swift
//  VU
//
//  Created by Pranav Karnani on 10/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DataHandler_fresh {
    
    static let shared : DataHandler_fresh = DataHandler_fresh()
    
    
    
    func persistAttendanceData(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            
            
            for item in attendanceDet.data {
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "AttendanceData", into: context)
                
                entity.setValue(item.attendance_Percentage, forKey: "percentage")
                entity.setValue(item.attended_Classes, forKey: "attendedclasses")
                entity.setValue(item.class_Nbr, forKey: "classnbr")
                entity.setValue(item.course_Code, forKey: "coursecode")
                entity.setValue(item.course_Title, forKey: "coursetitle")
                entity.setValue(item.course_Type, forKey: "coursetype")
                entity.setValue(item.faculty_Name, forKey: "facultyname")
                entity.setValue(item.serial_No, forKey: "sno")
                entity.setValue(item.slot, forKey: "slot")
                entity.setValue(item.total_Classes, forKey: "totalclasses")
                
                do {
                    try context.save()
                    x = x + 1
                    if x == attendanceDet.data.count {
                        completion(0)
                    }
                } catch {
                    print("error")
                    completion(1)
                }
                
            }
        }
    }
    
    func persistAcademicCalendar(completion : @escaping (Int) -> ()) {
        
        completion(0)
//        DispatchQueue.main.async {
//            var x = 0
//            let delegate = UIApplication.shared.delegate as! AppDelegate
//            let context = delegate.persistentContainer.viewContext
//            for item in calendar.data[0].data {
//                x = x + 1
//                let entity = NSEntityDescription.insertNewObject(forEntityName: "Calendar", into: context)
//
//                entity.setValue(item.type, forKey: "type")
//                entity.setValue(item.startDate, forKey: "startDate")
//                entity.setValue(item.endDate, forKey: "endDate")
//
//                do {
//                    try context.save()
//                    if x == calendar.data.count {
//                        completion(0)
//                    }
//                } catch {
//                    print("error")
//                    completion(1)
//                }
//            }
        
        }
//    }
    
    func persistUserDetails(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.insertNewObject(forEntityName: "MyDetails", into: context)
            
            entity.setValue(details.register_number, forKey: "username")
            entity.setValue(details.password, forKey: "password")
            entity.setValue(profile.data[0].branch, forKey: "branch")
            entity.setValue(profile.data[0].date_Of_Birth, forKey: "date_Of_Birth")
            entity.setValue(profile.data[0].gender, forKey: "gender")
            entity.setValue(profile.data[0].image_Data, forKey: "image_Data")
            entity.setValue(profile.data[0].mobile_Number, forKey: "mobile_Number")
            entity.setValue(profile.data[0].program, forKey: "program")
            entity.setValue(profile.data[0].school, forKey: "school")
            entity.setValue(profile.data[0].student_Name, forKey: "student_Name")
            
            isLoggedIn = true
            
            entity.setValue(isLoggedIn, forKey: "isLoggedIn")
            
            do {
                try context.save()
                completion(0)
            } catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func persistexamData(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in examScheduleDetails.data {
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "ExamDetails", into: context)
                entity.setValue(item.class_ID, forKey: "class_ID")
                entity.setValue(item.course_Code, forKey: "course_Code")
                entity.setValue(item.course_Title, forKey: "course_Title")
                entity.setValue(item.course_Type, forKey: "course_Type")
                entity.setValue(item.exam_Date, forKey: "exam_Date")
                entity.setValue(item.exam_Session, forKey: "exam_Session")
                entity.setValue(item.exam_Time, forKey: "exam_Time")
                entity.setValue(item.seat_Location, forKey: "seat_Location")
                entity.setValue(item.seat_Number, forKey: "seat_Number")
                entity.setValue(item.serial_No, forKey: "serial_No")
                entity.setValue(item.slot, forKey: "slot")
                entity.setValue(item.type, forKey: "type")
                entity.setValue(item.venue, forKey: "venue")
                
                do {
                    try context.save()
                    x = x + 1
                    if x == examScheduleDetails.data.count {
                        completion(0)
                    }
                } catch {
                    print("error")
                    completion(1)
                }
                
            }
        }
    }
    
    func persistFaculty(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in facultyList.data {
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "FacultyEntity", into: context)
                entity.setValue(item.designation, forKey: "designation")
                entity.setValue(item.name, forKey: "name")
                entity.setValue(item.venue, forKey: "venue")
                entity.setValue(item.intercom, forKey: "intercom")
                entity.setValue(item.mail, forKey: "mail")
                entity.setValue(item.imageData, forKey: "image")
                
                do {
                    try context.save()
                    x = x + 1
                    if x == facultyList.data.count {
                        completion(0)
                    }
                } catch {
                    print("error")
                    completion(1)
                }
                
            }
        }
    }
    
    func persistDetailedAttendance(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in detailedAttendanceData {
                x = x + 1
                for subitem in item.details {
                    let entity = NSEntityDescription.insertNewObject(forEntityName: "DetailedAttendance", into: context)
                    entity.setValue(item.class_Nbr, forKey: "class_Nbr")
                    entity.setValue(subitem.day_and_Timing, forKey: "day_and_Timing")
                    entity.setValue(subitem.attendance_Status, forKey: "attendance_Status")
                    entity.setValue(subitem.attendance_Slot, forKey: "attendance_Slot")
                    entity.setValue(subitem.attendance_Date, forKey: "attendance_Date")
                    
                    do {
                        try context.save()
                        
                        if x == detailedAttendanceData.count {
                            completion(0)
                        }
                    } catch {
                        print("error")
                        completion(1)
                    }
                    
                    if x == detailedAttendanceData.count {
                        break
                    }
                }
                
                if x == detailedAttendanceData.count {
                    break
                }
            }
        }
    }
    
    func persistAcademicHistory(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in historyDetails.data {
                
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "AcademicHistory", into: context)
                entity.setValue(item.course_Code, forKey: "course_Code")
                entity.setValue(item.course_Title, forKey: "course_Title")
                entity.setValue(item.course_Type, forKey: "course_Type")
                entity.setValue(item.credits, forKey: "credits")
                entity.setValue(item.exam_Month, forKey: "exam_Month")
                entity.setValue(item.grade, forKey: "grade")
                entity.setValue(item.node_Type, forKey: "node_Type")
                entity.setValue(item.result_Declared, forKey: "result_Declared")
                
                
                do {
                    try context.save()
                    x = x + 1
                    if x == historyDetails.data.count {
                        completion(0)
                    }
                    
                } catch {
                    print("error")
                    completion(1)
                }
            }
        }
    }
    
    func persistProctor(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in proctorData.data {
                
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "ProctorData", into: context)
                entity.setValue(item.cabin, forKey: "cabin")
                entity.setValue(item.faculty_Department, forKey: "faculty_Department")
                entity.setValue(item.faculty_Designation, forKey: "faculty_Designation")
                entity.setValue(item.faculty_Email, forKey: "faculty_Email")
                entity.setValue(item.faculty_ID, forKey: "faculty_ID")
                entity.setValue(item.faculty_Intercom, forKey: "faculty_Intercom")
                entity.setValue(item.faculty_Mobile_Number, forKey: "faculty_MobileNumber")
                entity.setValue(item.faculty_Name, forKey: "faculty_Name")
                entity.setValue(item.school, forKey: "school")
                
                do {
                    try context.save()
                    completion(0)
                } catch {
                    print("error")
                    completion(1)
                }
            }
        }
    }
    
    func persistTimetable(completion : @escaping (Int) -> ()) {
        var x = 0
        var z = 0
        var t = 0
        for item in timetableCluster.data {
            if item.Day?.count == 0 {
                x = x + 1
            }
        }

        let days : [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            
            for item in timetableCluster.data {
                x = x + 1
            
                for subitem in item.Day! {
                
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Timetable", into: context)
                    
                entity.setValue(subitem.course_Code, forKey: "course_Code")
                entity.setValue(subitem.course_Type, forKey: "course_Type")
                entity.setValue(subitem.end_Time, forKey: "endTime")
                entity.setValue(subitem.slot, forKey: "slot")
                entity.setValue(subitem.start_Time, forKey: "start_Time")
                entity.setValue(subitem.venue, forKey: "venue")
                print(days[t])
                entity.setValue(days[t], forKey: "day")
                
                do {
                    try context.save()
                    print(x)
                    if x == timetableCluster.data.count {
                        z = 1
                        break
                       
                    }
                } catch {
                    print("error")
                    completion(1)
                }
                }
                t = t+1
                
                
                if z == 1 {
                    completion(0)
                    break
                }
                
            }
        }
    }
    
    
    
    func persistMarks(completion : @escaping (Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            for item in marksData.data {
                x = x + 1
                for subitem in item.data {
                    let entity = NSEntityDescription.insertNewObject(forEntityName: "Marks", into: context)
                    entity.setValue(item.course_Title, forKey: "course_Title")
                    entity.setValue(item.course_Type, forKey: "course_Type")
                    entity.setValue(subitem.scored_Mark, forKey: "scored_Mark")
                    entity.setValue(subitem.max_mark, forKey: "max_mark")
                    entity.setValue(subitem.average, forKey: "average")
                    entity.setValue(subitem.count, forKey: "count")
                    entity.setValue(subitem.mark_Title, forKey: "mark_Title")
                    entity.setValue(subitem.weightage_Mark, forKey: "weightage_Mark")
                    entity.setValue(subitem.highest, forKey: "highest")
                    
                    
                    do {
                        try context.save()
                        if x == marksData.data.count {
                            completion(0)
                        }
                    } catch {
                        print("error")
                        completion(1)
                    }
                }
            }
        }
    }
    
    
    
    func retrieveUserDetails(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyDetails")
            
            do {
                let results = try context.fetch(request)
                var data : [ProfileStructure] = []
                for result in results as! [NSManagedObject] {
                    details.register_number = result.value(forKey: "username") as? String ?? "N/A"
                    details.password = result.value(forKey: "password") as? String ?? "N/A"
                    let studentName = result.value(forKey: "student_Name") as! String
                    let imageData = result.value(forKey: "image_Data") as? String ?? "N/A"
                    let structure = ProfileStructure(student_Name: studentName, date_Of_Birth: "NA", gender: "NA", program: "NA", branch: "NA", school: "NA", mobile_Number: "NA", image_Data: imageData)
                    data.append(structure)
                    
                    isLoggedIn = result.value(forKey: "isLoggedIn") as? Bool ?? false
                }
                profile = Profile(code: 200, message: "successful", data: data)
                completion(0)
            } catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func retrieveAttendanceData(completion : @escaping (Int) -> ()) {
        
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AttendanceData")
            
            do {
                let results = try context.fetch(request)
                var data : [attendanceStructure] = []
                for item in results as! [NSManagedObject] {
                    let percentage = item.value(forKey: "percentage") as? String ?? "N/A"
                    let attended = item.value(forKey: "attendedclasses") as? String ?? "N/A"
                    let coursecode = item.value(forKey: "coursecode") as? String ?? "N/A"
                    let coursetitle = item.value(forKey: "coursetitle") as? String ?? "N/A"
                    let coursetype = item.value(forKey: "coursetype") as? String ?? "N/A"
                    let faculty = item.value(forKey: "facultyname") as? String ?? "N/A"
                    let serial = item.value(forKey: "sno") as? String ?? "N/A"
                    let slot = item.value(forKey: "slot") as? String ?? "N/A"
                    let total = item.value(forKey:  "totalclasses") as? String ?? "N/A"
                    let nbr = item.value(forKey: "classnbr") as? String ?? "N/A"
                    
                    let structure = attendanceStructure(serial_No: serial, attendance_Percentage: percentage, attended_Classes: attended, class_Nbr : nbr, course_Code: coursecode, course_Title: coursetitle, course_Type: coursetype, faculty_Name: faculty, slot: slot, total_Classes: total)
                    
                    data.append(structure)
                }
                
                attendanceDet = attendanceCluster(code: 200, message: "successful", data: data)
                completion(0)
                
            } catch {
                print("error")
                completion(1)
            }
            
        }
    }
    
    func retrieveProctor(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProctorData")
            
            do {
                
                let results = try context.fetch(request)
                
                for item in results as! [NSManagedObject] {
                    let cabin = item.value(forKey: "cabin") as? String ?? "N/A"
                    let department = item.value(forKey: "faculty_Department") as? String ?? "N/A"
                    let designation = item.value(forKey: "faculty_Designation") as? String ?? "N/A"
                    let mail = item.value(forKey: "faculty_Email") as? String ?? "N/A"
                    let id = item.value(forKey: "faculty_ID") as? String ?? "N/A"
                    let intercom = item.value(forKey: "faculty_Intercom") as? String ?? "N/A"
                    let number = item.value(forKey: "faculty_MobileNumber") as? String ?? "N/A"
                    let name = item.value(forKey: "faculty_Name") as? String ?? "N/A"
                    let school = item.value(forKey: "school") as? String ?? "N/A"
                    
                    proctorData = Proctor(code: 200, message: "Success", data: [ProctorStructure(cabin: cabin, faculty_Department: department, faculty_Designation: designation, faculty_Email: mail, faculty_ID: id, faculty_Mobile_Number: number, faculty_Name: name, faculty_Intercom: intercom, school: school)])
                    
                    completion(0)
                }
                
                
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func retrieveFaculty(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FacultyEntity")
            
            do {
                
                let results = try context.fetch(request)
                
                for item in results as! [NSManagedObject] {
                    let name = item.value(forKey: "name") as? String ?? "N/A"
                    let designation = item.value(forKey: "designation") as? String ?? "N/A"
                    let mail = item.value(forKey: "mail") as? String ?? "N/A"
                    let intercom = item.value(forKey: "intercom") as? String ?? "N/A"
                    let data = item.value(forKey: "image") as? String ?? "N/A"
                    let venue = item.value(forKey: "venue") as? String ?? "N/A"
                    
                    let fact = FacultyBase(name: name, designation: designation, venue: venue, intercom: intercom, mail: mail, imageData: data)
                    
                    facultyList.data.append(fact)
                }
                completion(0)
                
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func retrieveExamSchedule(type : String, completion : @escaping(Int) -> ()) {
        
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExamDetails")
            
            do {
                request.predicate = NSPredicate(format: "type = %@", argumentArray: [type])
                let results = try context.fetch(request)
                
                for item in results as! [NSManagedObject] {
                    let id = item.value(forKey: "class_ID") as? String ?? "N/A"
                    let code = item.value(forKey: "course_Code") as? String ?? "N/A"
                    let title = item.value(forKey: "course_Title") as? String ?? "N/A"
                    let type = item.value(forKey: "course_Type") as? String ?? "N/A"
                    let date = item.value(forKey: "exam_Date") as? String ?? "N/A"
                    let session = item.value(forKey: "exam_Session") as? String ?? "N/A"
                    let time = item.value(forKey: "exam_Time") as? String ?? "N/A"
                    let seatlocation = item.value(forKey: "seat_Location") as? String ?? "N/A"
                    let seatnumber = item.value(forKey: "seat_Number") as? String ?? "N/A"
                    let serial = item.value(forKey: "serial_No") as? String ?? "N/A"
                    let slot = item.value(forKey: "slot") as? String ?? "N/A"
                    let exam_type = item.value(forKey: "type") as? String ?? "N/A"
                    let venue = item.value(forKey: "venue") as? String ?? "N/A"
                    
                    let examData = ExamScheduleStructure(serial_No: serial, course_Code: code, course_Title: title, course_Type: type, class_ID: id, slot: slot, exam_Date: date, exam_Session: session, exam_Time: time, venue: venue, seat_Location: seatlocation, seat_Number: seatnumber, type: exam_type)
                    
                    examScheduleDetails.data.append(examData)
                    
                }
                
                completion(0)
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    
    
    func retrieveDetailedAttendance(number: String, completion : @escaping(Int) -> ()) {
        var x = 0
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DetailedAttendance")
            
            do {
                request.predicate = NSPredicate(format: "class_Nbr=%@", argumentArray: [number])
                let results = try context.fetch(request)
                let count = results.count
                print(count)
                for result in results as! [NSManagedObject] {
                    x = x + 1
                    let date = result.value(forKey: "attendance_Date") as? String ?? "N/A"
                    let time = result.value(forKey: "day_and_Timing") as? String ?? "N/A"
                    let slot = result.value(forKey: "attendance_Slot") as? String ?? "N/A"
                    let status = result.value(forKey: "attendance_Status") as? String ?? "N/A"
                    
                    let base = detailedAttendanceStructure(serial_No : "\(x)", attendance_Date: date, attendance_Slot: slot, day_and_Timing: time, attendance_Status: status)
                    
                    dailyStructure.append(base)
                    
                    if x == count {
                        completion(0)
                    }
                    
                }
                
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func retrieveTimetable(day: String, completion : @escaping(Int) -> ()) {
        var x = 0
        
        timetableForToday.removeAll()
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Timetable")
            let sort = NSSortDescriptor(key: "start_Time", ascending: true)
            request.sortDescriptors = [sort]
            do {
                request.predicate = NSPredicate(format: "day == %@", day)
                
                let results = try context.fetch(request)
                let count = results.count

                for result in results as! [NSManagedObject] {
                    x = x + 1
                    
                    let code = result.value(forKey: "course_Code") as? String ?? "N/A"
                    let type = result.value(forKey: "course_Type") as? String ?? "N/A"
                    let etime = result.value(forKey: "endTime") as? String ?? "N/A"
                    let stime = result.value(forKey: "start_Time") as? String ?? "N/A"
                    let slot = result.value(forKey: "slot") as? String ?? "N/A"
                    let venue = result.value(forKey: "venue") as? String ?? "N/A"
                    
                    
                    
                    let base = TimetableBaseStructure(course_Code: code, course_Type: type, slot: slot, venue: venue, start_Time: stime, end_Time: etime)
                    timetableForToday.append(base)
                    
                    
           
                
                    
                }
                completion(0)
                
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    
    
    func retrieveMarks(completion : @escaping (Int) -> ()) {
        
        DispatchQueue.main.async {
            var x = 0
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Marks")
            
            do {
                
                let results = try context.fetch(request)
                
                for item in results as! [NSManagedObject] {
                    x = x + 1
                    let title = item.value(forKey: "course_Title") as? String ?? "N/A"
                    let type = item.value(forKey: "course_Type") as? String ?? "N/A"
                    let scoredMarks = item.value(forKey: "scored_Mark") as? String ?? "N/A"
                    let maxMarks = item.value(forKey: "max_mark") as? String ?? "N/A"
                    let avg = item.value(forKey: "average") as? String ?? "N/A"
                    let count = item.value(forKey: "count") as? String ?? "N/A"
                    let mtitle = item.value(forKey: "mark_Title") as? String ?? "N/A"
                    let weightage = item.value(forKey: "weightage_Mark") as? String ?? "N/A"
                    let highest = item.value(forKey: "highest") as? String ?? "N/A"
                    
                    myMarks.append(RetrievedMarks(courseTitle: title, courseType: type, scored: scoredMarks, max: maxMarks, avg: avg, mTitle: mtitle, weightage: weightage, count: count, highest: highest))
                    
                    if x == results.count {
                        completion(0)
                    }
                }
                
                
            }catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func retrieveCalendar(completion : @escaping (Int) -> ()) {
        DispatchQueue.main.async {
            var events : [Description] = []
            var x = 0
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Calendar")
            
            do {
                let results = try context.fetch(request)
                
                for result in results as! [NSManagedObject] {
                    x = x + 1
                    let type = result.value(forKey: "type") as? String ?? "N/A"
                    let sdate = result.value(forKey: "startDate") as? String ?? "N/A"
                    let edate = result.value(forKey: "endDate") as? String ?? "N/A"
                    
                    let cal = Description(type: type, startDate: sdate, endDate: edate)
                    
                    events.append(cal)
                    
                    if x == results.count {
                        let cale = AcademicCalender(_id : "",title : "", data: events)
                        calendar = AcademicCalBase(code: 0, message: "", data: [cale])
                        completion(0)
                    }
                    
                }
                
                
            } catch {
                print("error")
                completion(1)
            }
        }
    }
    
    func delete(entities : [String]) {
        for item in entities {
            deleteData(entity: item)
        }
    }
    
    func deleteData(entity : String) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            request.returnsObjectsAsFaults = false
            
            do
            {
                let results = try context.fetch(request)
                for object in results
                {
                    let data = object as! NSManagedObject
                    context.delete(data)
                }
            } catch let error as NSError {
                print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
            }
        }
        
    }
    
    
}

