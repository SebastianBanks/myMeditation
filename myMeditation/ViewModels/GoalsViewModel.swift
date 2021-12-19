//
//  GoalsViewModel.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/6/21.
//

import Foundation
import SwiftUI
import Combine

enum meditateGoal {
    static let sun = "sundayMeditate"
    static let mon = "mondayMeditate"
    static let tues = "tuesdayMeditate"
    static let wed = "wednesdayMeditate"
    static let thur = "thursdayMeditate"
    static let fri = "fridayMeditate"
    static let sat = "saturdayMeditate"
}

class GoalsViewModel: ObservableObject {
    
    @ObservedObject var notificationManager = NotificationManager()
    @ObservedObject var coreData = CoreData()
    var currentWeek = weekData(sun: 0.0, mon: 0.0, tues: 0.0, wed: 0.0, thur: 0.0, fri: 0.0, sat: 0.0)
    @Published var currentWeekData: [ChartData] = []
    
    
    @Published var streak: Int = 0
    @Published var bestStreak: Int = 0
    @Published var meditatedToday: Int = 0
    @Published var meditatedWeek: Int = 0
    @Published var meditatedTotal: Int = 0
    @Published var meditationSessions: Int = 0
    @Published var longestSession: Int = 0
    
    @AppStorage(meditateGoal.sun, store: .standard) var sunGoal: Bool = false
    @AppStorage(meditateGoal.mon, store: .standard) var monGoal: Bool = false
    @AppStorage(meditateGoal.tues, store: .standard) var tuesGoal: Bool = false
    @AppStorage(meditateGoal.wed, store: .standard) var wedGoal: Bool = false
    @AppStorage(meditateGoal.thur, store: .standard) var thurGoal: Bool = false
    @AppStorage(meditateGoal.fri, store: .standard) var friGoal: Bool = false
    @AppStorage(meditateGoal.sat, store: .standard) var satGoal: Bool = false
    
    var passThrough = PassthroughSubject<(Double, Date), Never>()
    var cancellables = Set<AnyCancellable>()
    let calendar = Calendar.current
    let today: Date
    let startOfWeek: Date
    var excluded: [Int] = []
    
    
    init() {
        today = calendar.startOfDay(for: Date())
        startOfWeek = calendar.startOfWeek(for: today) ?? today
        
        
    }
    
    func getExcluded() {
        self.excluded = []
        
        if sunGoal == false {
            excluded.append(1)
        }
        if monGoal == false {
            excluded.append(2)
        }
        if tuesGoal == false {
            excluded.append(3)
        }
        if wedGoal == false {
            excluded.append(4)
        }
        if thurGoal == false {
            excluded.append(5)
        }
        if friGoal == false {
            excluded.append(6)
        }
        if satGoal == false {
            excluded.append(7)
        }
    }
    
    func updateViewData() {
        getChartData()
        getMeditatedToday()
        getMeditatedThisWeek()
        getTotalSessions()
        getTotalMeditated()
        getLongestSession()
        getExcluded()
        getStreak()
        getLongestStreak()
        
    }
    
    func getChartData() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        let currentWeekData = entities.filter({ entite in
            entite.date ?? today >= startOfWeek
        })
        self.currentWeek.sun = 0.0
        self.currentWeek.mon = 0.0
        self.currentWeek.tues = 0.0
        self.currentWeek.wed = 0.0
        self.currentWeek.thur = 0.0
        self.currentWeek.fri = 0.0
        self.currentWeek.sat = 0.0
        
        for session in currentWeekData {
            switch session.date?.dayNumberOfWeek() {
            case 1:
                self.currentWeek.sun += session.timeMeditated
            case 2:
                self.currentWeek.mon += session.timeMeditated
            case 3:
                self.currentWeek.tues += session.timeMeditated
            case 4:
                self.currentWeek.wed += session.timeMeditated
            case 5:
                self.currentWeek.thur += session.timeMeditated
            case 6:
                self.currentWeek.fri += session.timeMeditated
            case 7:
                self.currentWeek.sat += session.timeMeditated
            default:
                self.currentWeek.sun += 0.0
                self.currentWeek.mon += 0.0
                self.currentWeek.tues += 0.0
                self.currentWeek.wed += 0.0
                self.currentWeek.thur += 0.0
                self.currentWeek.fri += 0.0
                self.currentWeek.sat += 0.0
            }
            
            print("sun - \(self.currentWeek.sun)")
            print("mon - \(self.currentWeek.mon)")
            print("tues - \(self.currentWeek.tues)")
            print("wed - \(self.currentWeek.wed)")
            print("thur - \(self.currentWeek.thur)")
            print("fri - \(self.currentWeek.fri)")
            print("sat - \(self.currentWeek.sat)")
            
            self.currentWeekData = [
                ChartData(label: "sun", value: self.currentWeek.sun),
                ChartData(label: "mon", value: self.currentWeek.mon),
                ChartData(label: "tues", value: self.currentWeek.tues),
                ChartData(label: "wed", value: self.currentWeek.wed),
                ChartData(label: "thur", value: self.currentWeek.thur),
                ChartData(label: "fri", value: self.currentWeek.fri),
                ChartData(label: "sat", value: self.currentWeek.sat),
            ]
            
            for value in self.currentWeekData {
                print("label: \(value.label), value: \(value.value)")
            }
        }
        
    }
    
    func getMeditatedToday() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        let todayMeditated = entities.filter({ entity in
            entity.date ?? today == today
        })
        self.meditatedToday = 0
        
        for session in todayMeditated {
            self.meditatedToday += (Int(session.timeMeditated) / 60)
        }
    }

    func getMeditatedThisWeek() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        let currentWeekData = entities.filter({ entite in
            entite.date ?? today >= startOfWeek
        })
        self.meditatedWeek = 0
        
        for session in currentWeekData {
            self.meditatedWeek += (Int(session.timeMeditated) / 60)
        }
    }
    
    func getTotalSessions() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        self.meditationSessions = 0
        for entity in entities {
            if entity.timeMeditated != 0 && entity.date != nil {
                self.meditationSessions += 1
            }
        }
    }
    
    func getTotalMeditated() {
        self.coreData.getSessions()
        let entities = self.coreData.savedSessionEntites
        self.meditatedTotal = 0
        for entity in entities {
            self.meditatedTotal += (Int(entity.timeMeditated) / 60)
        }
    }
    
    func getLongestSession() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        var longestSession2 = 0
        
        for entity in entities {
            if (Int(entity.timeMeditated) / 60) >= longestSession {
                longestSession2 = (Int(entity.timeMeditated) / 60)
            }
        }
        
        self.longestSession = longestSession2
    }
    
    func getStreak() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites.reversed()
        var datesMeditated: [Int] = []
        var tempStreak = 0
        
        for entity in entities {
            datesMeditated.append(entity.date?.dayNumberOfWeek() ?? 0)
        }
        
//        if datesMeditated.isEmpty != true {
//            if datesMeditated[0] == self.today.dayNumberOfWeek() {
//                tempStreak += 1
//            }
//        }
        if datesMeditated != [] {
            var prev = datesMeditated.first!
            
            for index in 1..<datesMeditated.count {
                let weekday = datesMeditated[index]
                let previousWeekday = prev
                print("Weekday: \(weekday)")
                print("Previous Weekday: \(previousWeekday)")
                
                if tempStreak == 0 && previousWeekday == self.today.dayNumberOfWeek() {
                    tempStreak += 1
                    print("tempStreak: \(tempStreak)")
                }
                
                if previousWeekday - 1 == weekday || excluded.contains(previousWeekday - 1) {
                    prev = weekday
                    tempStreak += 1
                    print("tempStreak: \(tempStreak)")
                    print("1st")
                    continue
                } else if previousWeekday == weekday {
                    print("2nd")
                    prev = weekday
                    print("tempStreak: \(tempStreak)")
                    continue
                } else if previousWeekday == 1 && weekday == 7 {
                    tempStreak += 1
                    prev = weekday
                    print("3rd")
                    print("tempStreak: \(tempStreak)")
                    continue
                }
                
                
                print("break")
                break
            }

        }
          //Change to a guard statement or similar

        
        self.streak = tempStreak
        print("datesMeditated: \(datesMeditated)")
        print("excluded: \(excluded)")
        
    }
    
    func getLongestStreak() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites.reversed()
        var datesMeditated: [Int] = []
        for entity in entities {
            datesMeditated.append(entity.date?.dayNumberOfWeek() ?? 0)
        }
        
        var x = 0
        var z = x + 1
        var tempStreak = 0
        var currentStreak = 0
        
        if datesMeditated.isEmpty != true {
            if datesMeditated[0] == self.today.dayNumberOfWeek() {
                tempStreak += 1
            }
        }
                
        while x + 1 < datesMeditated.count {
            
            if datesMeditated.isEmpty == true {
                break
            }
            
            if datesMeditated[x] == datesMeditated[z] + 1 {
                currentStreak += 1
            } else if datesMeditated[x] == 1 && datesMeditated[z] == 7 {
                currentStreak += 1
            } else if datesMeditated[x] > datesMeditated[z] && datesMeditated[x] != datesMeditated[z] + 1 || datesMeditated[x] < datesMeditated[z] {
                if currentStreak > tempStreak {
                    tempStreak = currentStreak
                    currentStreak = 0
                } else {
                    currentStreak = 0
                }
            } else if z + 1 == datesMeditated.count {
                if currentStreak > tempStreak {
                    tempStreak = currentStreak
                    currentStreak = 0
                } else {
                    currentStreak = 0
                }
            }
            
            self.bestStreak = tempStreak
            
            print("x: \(x)")
            print("z: \(z)")
            print("datesMeditated x: \(datesMeditated[x])")
            print("datesMeditated z: \(datesMeditated[z])")
            print("streak: \(tempStreak)")
            print("currentStreak: \(currentStreak)")
            x += 1
            z += 1
            
        }
    }
    
    
    func getColor(key: String) -> Color {
        
        
        switch key {
        case meditateGoal.sun:
            if UserDefaults.standard.bool(forKey: meditateGoal.sun) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.mon:
            if UserDefaults.standard.bool(forKey: meditateGoal.mon) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.tues:
            if UserDefaults.standard.bool(forKey: meditateGoal.tues) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.wed:
            if UserDefaults.standard.bool(forKey: meditateGoal.wed) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.thur:
            if UserDefaults.standard.bool(forKey: meditateGoal.thur) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.fri:
            if UserDefaults.standard.bool(forKey: meditateGoal.fri) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        case meditateGoal.sat:
            if UserDefaults.standard.bool(forKey: meditateGoal.sat) == true {
                return Color.init("ProgressBar")
            } else {
                return Color.init("ButtonColor")
            }
        default:
            print("key not identified")
            return .gray
        }
    }
    
    func createNotifications(date: Date) {
        if notificationManager.meditationReminderOn == true {
            notificationManager.deleteReminderNotification()
            notificationManager.reloadNotifications()
            
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
            guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
            
            if sunGoal == true {
    
                notificationManager.createMeditationReminderSun(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("sunday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if monGoal == true {
                
                notificationManager.createMeditationReminderMon(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("monday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if tuesGoal == true {
                
                notificationManager.createMeditationReminderTues(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("tuesday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if wedGoal == true {
                
                notificationManager.createMeditationReminderWed(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("wednesday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if thurGoal == true {
                
                notificationManager.createMeditationReminderThur(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("thursday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if friGoal == true {
                
                notificationManager.createMeditationReminderFri(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("friday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
            if satGoal == true {
                
                notificationManager.createMeditationReminderSat(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("saturday notification error: \(error.localizedDescription)")
                    }

                })
                notificationManager.reloadNotifications()
            }
            
        notificationManager.reloadNotifications()
            

        }
    }
    
    
    
    /* future combine pipeline
     
     
     
    func coreDataSub() {
        coreData.$savedSessionEntites
            .sink { completion in
                print("core data completion: \(completion)")
            } receiveValue: { [weak self] values in
                guard let self = self else { return }
                
                for value in values {
                    let timeMeditated = value.timeMeditated
                    let date = value.date ?? self.today
                    
                    self.passThrough.send((timeMeditated, date))
                }
            }
            .store(in: &cancellables)
   
    }
    
    
    func passThroughSubTimeMeditated() {
        passThrough
            .sink { completion in
                print("meditated total completion \(completion)")
            } receiveValue: { [weak self] (meditationTime, dateMeditated) in
                guard let self = self else { return }
                
                
                self.meditatedTotal += Int(meditationTime)
                
                if self.calendar.isDate(dateMeditated, equalTo: Date(), toGranularity: .day) {
                    self.meditatedToday += Int(meditationTime)
                }
                
                if dateMeditated >= self.startOfWeek {
                    self.meditatedWeek += Int(meditationTime)
                }
            }
            .store(in: &cancellables)
    }
    
    func passThroughSubYearData() {
        passThrough
            .filter { meditationTime, dateMeditated in
                if self.calendar.isDate(dateMeditated, equalTo: Date(), toGranularity: .year) {
                    return true
                } else {
                    return false
                }
            }
            .sink { completion in
                print("year data completion: \(completion)")
            } receiveValue: { [weak self] meditationTime, dateMeditated in
                guard let self = self else { return }
                
                let month = self.calendar.component(.month, from: dateMeditated)
                
                
                switch month {
                case 1:
                    self.yearData.jan += meditationTime
                case 2:
                    self.yearData.feb += meditationTime
                case 3:
                    self.yearData.mar += meditationTime
                case 4:
                    self.yearData.apr += meditationTime
                case 5:
                    self.yearData.may += meditationTime
                case 6:
                    self.yearData.jun += meditationTime
                case 7:
                    self.yearData.jul += meditationTime
                case 8:
                    self.yearData.aug += meditationTime
                case 9:
                    self.yearData.sep += meditationTime
                case 10:
                    self.yearData.oct += meditationTime
                case 11:
                    self.yearData.nov += meditationTime
                case 12:
                    self.yearData.dec += meditationTime
                default:
                    self.yearData.jan += 0.0
                    self.yearData.feb += 0.0
                    self.yearData.mar += 0.0
                    self.yearData.apr += 0.0
                    self.yearData.may += 0.0
                    self.yearData.jun += 0.0
                    self.yearData.jul += 0.0
                    self.yearData.aug += 0.0
                    self.yearData.sep += 0.0
                    self.yearData.oct += 0.0
                    self.yearData.nov += 0.0
                    self.yearData.dec += 0.0
                }
                
                self.currentYearData = [
                    ChartData(label: "jan", value: self.yearData.jan),
                    ChartData(label: "feb", value: self.yearData.feb),
                    ChartData(label: "mar", value: self.yearData.mar),
                    ChartData(label: "apr", value: self.yearData.apr),
                    ChartData(label: "may", value: self.yearData.may),
                    ChartData(label: "jun", value: self.yearData.jun),
                    ChartData(label: "jul", value: self.yearData.jul),
                    ChartData(label: "aug", value: self.yearData.aug),
                    ChartData(label: "sep", value: self.yearData.sep),
                    ChartData(label: "oct", value: self.yearData.oct),
                    ChartData(label: "nov", value: self.yearData.nov),
                    ChartData(label: "dec", value: self.yearData.dec)
                ]
            }
            .store(in: &cancellables)

    }
    
    func passThroughSubMonthData() {
        passThrough
            .filter { meditationTime, dateMeditated in
                if self.calendar.isDate(dateMeditated, equalTo: Date(), toGranularity: .month) {
                    return true
                } else {
                    return false
                }
            }
            .sink { completion in
                print("pass through month completion: \(completion)")
            } receiveValue: { [weak self] meditationTime, dateMeditated in
                guard let self = self else { return }
                
                let week = self.calendar.component(.weekOfMonth, from: dateMeditated)
                
                switch week {
                case 1:
                    self.monthData.week1 += meditationTime
                case 2:
                    self.monthData.week2 += meditationTime
                case 3:
                    self.monthData.week3 += meditationTime
                case 4:
                    self.monthData.week4 += meditationTime
                case 5:
                    self.monthData.week5 += meditationTime
                default:
                    self.monthData.week1 += 0.0
                    self.monthData.week2 += 0.0
                    self.monthData.week3 += 0.0
                    self.monthData.week4 += 0.0
                    self.monthData.week5 += 0.0
                }
                
                
                
                self.currentMonthData = [
                    ChartData(label: "w1", value: self.monthData.week1),
                    ChartData(label: "w2", value: self.monthData.week2),
                    ChartData(label: "w3", value: self.monthData.week3),
                    ChartData(label: "w4", value: self.monthData.week4),
                    ChartData(label: "w5", value: self.monthData.week5)
                ]
            }
            .store(in: &cancellables)

    }
    
    func passThroughWeekData() {
        passThrough
            .filter { meditatedTime, dateMeditated in
                if dateMeditated >= self.startOfWeek {
                    return true
                } else {
                    return false
                }
            }
            .sink { completion in
                print("week data completion: \(completion)")
            } receiveValue: { [weak self] meditatedTime, dateMeditated in
                guard let self = self else { return }
                
                switch dateMeditated.dayNumberOfWeek() {
                case 1:
                    self.weekData.sun += meditatedTime
                case 2:
                    self.weekData.mon += meditatedTime
                case 3:
                    self.weekData.tues += meditatedTime
                case 4:
                    self.weekData.wed += meditatedTime
                case 5:
                    self.weekData.thur += meditatedTime
                case 6:
                    self.weekData.fri += meditatedTime
                case 7:
                    self.weekData.sat += meditatedTime
                default:
                    self.weekData.sun += 0.0
                    self.weekData.mon += 0.0
                    self.weekData.tues += 0.0
                    self.weekData.wed += 0.0
                    self.weekData.thur += 0.0
                    self.weekData.fri += 0.0
                    self.weekData.sat += 0.0
                }
                
                self.currrentWeekData = [
                    ChartData(label: "sun", value: self.weekData.sun),
                    ChartData(label: "mon", value: self.weekData.mon),
                    ChartData(label: "tue", value: self.weekData.tues),
                    ChartData(label: "wed", value: self.weekData.wed),
                    ChartData(label: "thu", value: self.weekData.thur),
                    ChartData(label: "fri", value: self.weekData.fri),
                    ChartData(label: "sat", value: self.weekData.sat)
                ]
                
            }
            .store(in: &cancellables)

    }
     */
    
}

extension Calendar {
  func intervalOfWeek(for date: Date) -> DateInterval? {
    dateInterval(of: .weekOfYear, for: date)
  }

  func startOfWeek(for date: Date) -> Date? {
    intervalOfWeek(for: date)?.start
  }
}

extension ChartData: Equatable {
    static func == (lhs: ChartData, rhs: ChartData) -> Bool {
        return
            lhs.label == rhs.label &&
            lhs.value == rhs.value
    }
}
