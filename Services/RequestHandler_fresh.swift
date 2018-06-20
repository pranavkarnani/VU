//
//  RequestHandler_fresh.swift
//  VU
//
//  Created by Pranav Karnani on 10/02/18.
//  Copyright © 2018 Rishabh Mittal. All rights reserved.
//

import Foundation

class RequestsHandler_fresh {
    
    static let shared : RequestsHandler_fresh = RequestsHandler_fresh()
    
    var list : [String] = ["AcademicHistory"]
    
    func firstLogin(completion : @escaping (Int) -> ()) {
        
        fetchProfile { (profileFetched) in
            if profileFetched == 0 {
                self.fetchAttendance { (attendanceFetched) in
                    if attendanceFetched == 0 {
                        self.fetchExam { (examFetched) in
                            if examFetched == 0 {
                                DataHandler_fresh.shared.retrieveExamSchedule(type: "CAT1", completion: { (examFetched) in
                                    if examFetched == 0 {
                                        self.fetchTimetable(completion: { (timetableFetched) in
                                            if timetableFetched == 0 {
                                                self.fetchProctor { (proctorFetched) in
                                                    if proctorFetched == 0 {
                                                        self.fetchDetailedAttendance { (detailedFetched) in
                                                            if detailedFetched == 0 {
                                                                self.fetchMarks(completion: { (marksFetched) in
                                                                    if marksFetched == 0 {
                                                                        self.fetchAcademicCalendar(completion: { (calendarFetched) in
                                                                            if calendarFetched == 0 {
                                                                                DataHandler_fresh.shared.persistUserDetails(completion: { (detailsPersisted) in
                                                                                    if detailsPersisted == 0 {
                                                                                        completion(0)
                                                                                    }
                                                                                    else {
                                                                                        DataHandler_fresh.shared.delete(entities: self.list)
                                                                                        completion(1)
                                                                                    }
                                                                                })
                                                                            }
                                                                            else {
                                                                                DataHandler_fresh.shared.delete(entities: self.list)
                                                                                completion(1)
                                                                            }
                                                                        })
                                                                        
                                                                    }
                                                                    else {
                                                                        DataHandler_fresh.shared.delete(entities: self.list)
                                                                        completion(1)
                                                                    }
                                                                })
                                                                
                                                            }
                                                            else {
                                                                DataHandler_fresh.shared.delete(entities: self.list)
                                                                completion(1)
                                                            }
                                                        }
                                                        
                                                    }
                                                    else {
                                                        DataHandler_fresh.shared.delete(entities: self.list)
                                                        completion(1)
                                                    }
                                                }
                                            }
                                            else {
                                                DataHandler_fresh.shared.delete(entities: self.list)
                                                completion(1)
                                            }
                                        })
                                    }
                                    else {
                                        DataHandler_fresh.shared.delete(entities: self.list)
                                        completion(1)
                                    }
                                    
                                })
                            }
                                
                            else {
                                DataHandler_fresh.shared.delete(entities: self.list)
                                completion(1)
                            }
                        }
                    }
                    else {
                        DataHandler_fresh.shared.delete(entities: self.list)
                        completion(1)
                    }
                }
            }
            else {
                DataHandler_fresh.shared.delete(entities: self.list)
                completion(1)
            }
            
        }
    }
    
    func fetchAttendance(completion : @escaping (Int) -> ()) {
        print(attendanceURL)
        URLSession.shared.dataTask(with: URL(string : attendanceURL)!)  { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    
                    attendanceDet = try JSONDecoder().decode(attendanceCluster.self, from: data)
                    DataHandler_fresh.shared.persistAttendanceData(completion: { (status) in
                        if status == 0 {
                            completion(0)
                        }
                        else {
                            completion(1)
                        }
                    })
                    
                } catch {
                    print("json error: \(error.localizedDescription)")
                    print("catch")
                    completion(1)
                }
            }
            
            }.resume()
    }
    
    
    func fetchProctor(completion : @escaping (Int) -> ()) {
        print(proctorURL)
        URLSession.shared.dataTask(with: URL(string : proctorURL)!) { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    proctorData = try JSONDecoder().decode(Proctor.self, from: data)
                    DataHandler_fresh.shared.persistProctor(completion: { (detailsPersisted) in
                        if detailsPersisted == 0 {
                            completion(0)
                        } else {
                            completion(1)
                        }
                    })
                    
                }catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
                
                
            }
            }.resume()
    }
    
    func fetchTimetable(completion : @escaping (Int) -> ()) {
        print(timetableURL)
        
        URLSession.shared.dataTask(with: URL(string : timetableURL)!) { (data, response, error) in
            if error != nil {
                completion(1)
            }
            else {
                
                guard let data = data else { return }
                
                do {
                    timetableCluster = try JSONDecoder().decode(TimetableCluster.self, from: data)
                    DataHandler_fresh.shared.persistTimetable(completion: { (timetablePersisted) in
                        if timetablePersisted == 0 {
                            completion(0)
                        }
                    })
                }catch {
                    print("\(error.localizedDescription)")
                    completion(1)
                }
                
                
                
                
            }
            }.resume()
        
    }
    
    
    
    func fetchProfile(completion : @escaping (Int) -> ()) {
        print(profileURL)
        URLSession.shared.dataTask(with: URL(string : profileURL)!) { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(0)
                }
                    
                catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func fetchFaculty(completion : @escaping (Int) -> ()) {
        print(facultyURL)
        URLSession.shared.dataTask(with: URL(string : facultyURL)!) { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    
                    facultyList = try JSONDecoder().decode(Faculty.self, from: data)
                    DataHandler_fresh.shared.persistFaculty(completion: { (facultyFetched) in
                        if facultyFetched == 0 {
                            completion(0)
                        }
                    })
                    
                }
                    
                catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func fetchHistory(completion : @escaping (Int) -> ()) {
        print(historyURL)
        URLSession.shared.dataTask(with: URL(string : historyURL)!) { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    historyDetails = try JSONDecoder().decode(History.self, from: data)
                    DataHandler_fresh.shared.persistAcademicHistory(completion: { (historyPersisted) in
                        if historyPersisted == 0 {
                            completion(0)
                        }
                    })
                    
                    
                }
                    
                catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    
    func fetchExam(completion : @escaping (Int) -> ()) {
        print(examScheduleURL)
        URLSession.shared.dataTask(with: URL(string : examScheduleURL)!) { (data, response, error) in
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                
                do {
                    examScheduleDetails = try JSONDecoder().decode(ExamSchedule.self, from: data)
                    DataHandler_fresh.shared.persistexamData(completion: { (examDataPersisted) in
                        if examDataPersisted == 0 {
                            completion(0)
                        }
                    })
                    
                    
                }
                    
                catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func fetchDetailedAttendance(completion : @escaping (Int) -> ()) {
        
//        var x = 0
//        for item in attendanceDet.data {
//            detailedAttendanceURL = base_URL + "/attendance/details/\(details.register_number)?slot="
//            detailedAttendanceURL = detailedAttendanceURL+"\(item.slot.replacingOccurrences(of: "+", with: "%2B"))&class_Nbr=\(item.class_Nbr)"
//            print(detailedAttendanceURL)
//            URLSession.shared.dataTask(with: URL(string : detailedAttendanceURL)!) { (data, response, error) in
//
//                if error != nil {
//                    completion(1)
//                }
//                else {
//                    guard let data = data else { return }
//
//                    do {
//                        detailedAtt = try JSONDecoder().decode(detailedAttendance.self, from: data)
//                        let baseStruct = DetailedAttendanceBase(class_Nbr : item.class_Nbr, details: detailedAtt.data)
//                        detailedAttendanceData.append(baseStruct)
//
//                        x = x + 1
//                        if x == attendanceDet.data.count {
//                            DataHandler_fresh.shared.persistDetailedAttendance(completion: { (detailedPersisted) in
//                                if detailedPersisted == 0 {
//                                    completion(0)
//                                }
//                            })
//                        }
//
//                    }
//
//                    catch {
//                        completion(1)
//                        print("\(error.localizedDescription)")
//                    }
//
//                }
//
//                }.resume()
//        }
        completion(0)
    }
    
    func fetchMarks(completion : @escaping (Int) -> ()) {
        print(markURL)
        URLSession.shared.dataTask(with: URL(string : markURL)!) { (data, response, error) in
            
            if error != nil {
                completion(1)
            }
            else {
                guard let data = data else { return }
                
                do {
                    marksData = try JSONDecoder().decode(MarksCluster.self, from: data)
                    //completion(0)
                    DataHandler_fresh.shared.persistMarks(completion: { (marksPersisted) in
                        if marksPersisted == 0 {
                            completion(0)
                        }
                    })
                    
                    
                }
                    
                catch {
                    completion(1)
                    print("\(error.localizedDescription)")
                }
                
            }
            
            }.resume()
    }
    
    func fetchAcademicCalendar(completion : @escaping (Int) -> ()) {
//        URLSession.shared.dataTask(with: URL(string : calendarURL)!) { (data, response, error) in
//            if error != nil {
//                print("error")
//                completion(1)
//            }
//
//            guard let data = data else { return }
//
//
//            do {
//                calendar = try JSONDecoder().decode(AcademicCalBase.self, from: data)
//                DataHandler_fresh.shared.persistAcademicCalendar(completion: { (calendarPersisted) in
//                    if calendarPersisted == 0 {
//                        completion(0)
//                    }
//                })
//
//
//            } catch {
//                print("\(error.localizedDescription)")
//                completion(1)
//            }
//
        
//        }.resume()
        
        completion(0)
    }
    
    func performLogin(completion : @escaping(Int) -> ()) {
        print(loginURL)
        
        let jsonData = try? JSONEncoder().encode(details)
        // statusCode = 200
        var request = URLRequest(url: URL(string: loginURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            
            guard let data = data else { return }
            
            do{
                let stats = try JSONDecoder().decode(NetworkStatus.self, from: data)
                print(stats.code!)
                statusCode = stats.code!
                if stats.code! == 200 {
                    self.firstLogin(completion: { (loginStatus) in
                        if loginStatus == 0 {
                            completion(0)
                        } else {
                            completion(1)
                        }
                    })
                }
                
                else {
                    completion(1)
                    print("error in logging in")
                }
            } catch {
                print("error")
            }
            
            }.resume()
    }
}

