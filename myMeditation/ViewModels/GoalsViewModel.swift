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
    var currentMonth = monthData(week1: 0.0, week2: 0.0, week3: 0.0, week4: 0.0)
    var currentYear = yearData(jan: 0.0, feb: 0.0, mar: 0.0, apr: 0.0, may: 0.0, jun: 0.0, jul: 0.0, aug: 0.0, sep: 0.0, oct: 0.0, nov: 0.0, dec: 0.0)
    @Published var currentWeekData: [ChartData] = []
    @Published var currentMonthData: [ChartData] = []
    @Published var currentYearData: [ChartData] = []
    
    
    @Published var streak: Int = 0
    @Published var bestStreak: Int = 0
    @Published var meditatedToday: Int = 0
    @Published var meditatedWeek: Double = 0.0
    @Published var meditatedTotal: Double = 0.0
    @Published var meditationSessions: Int = 0
    @Published var longestSession: Double = 0.0
    
    @AppStorage(meditateGoal.sun, store: .standard) var sunGoal: Bool = false
    @AppStorage(meditateGoal.mon, store: .standard) var monGoal: Bool = false
    @AppStorage(meditateGoal.tues, store: .standard) var tuesGoal: Bool = false
    @AppStorage(meditateGoal.wed, store: .standard) var wedGoal: Bool = false
    @AppStorage(meditateGoal.thur, store: .standard) var thurGoal: Bool = false
    @AppStorage(meditateGoal.fri, store: .standard) var friGoal: Bool = false
    @AppStorage(meditateGoal.sat, store: .standard) var satGoal: Bool = false
    
    let calendar = Calendar.current
    let today: Date
    let startOfWeek: Date
    let startOfMonth: Date
    let startOfYear: Date
    var excluded: [Int] = []
    
    
    init() {
        today = calendar.startOfDay(for: Date())
        startOfWeek = calendar.startOfWeek(for: today) ?? today
        startOfMonth = calendar.startOfMonth(for: today) ?? today
        startOfYear = calendar.startOfYear(for: today) ?? today
        
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
        getWeekChartData()
        getMonthChartData()
        getYearChartData()
        getMeditatedToday()
        getMeditatedThisWeek()
        getTotalSessions()
        getTotalMeditated()
        getLongestSession()
        getExcluded()
        getStreak()
        getLongestStreak()
        
    }
    
    func getWeekChartData() {
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
            
            self.currentWeekData = [
                ChartData(label: "sun", value: self.currentWeek.sun),
                ChartData(label: "mon", value: self.currentWeek.mon),
                ChartData(label: "tues", value: self.currentWeek.tues),
                ChartData(label: "wed", value: self.currentWeek.wed),
                ChartData(label: "thur", value: self.currentWeek.thur),
                ChartData(label: "fri", value: self.currentWeek.fri),
                ChartData(label: "sat", value: self.currentWeek.sat),
            ]
            
        }
        
    }
    
    func getMonthChartData() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        let currentMonthData = entities.filter({ entite in
            entite.date ?? today >= startOfMonth
        })
        
        self.currentMonth.week1 = 0.0
        self.currentMonth.week2 = 0.0
        self.currentMonth.week3 = 0.0
        self.currentMonth.week4 = 0.0
        
        for session in currentMonthData {
            switch session.date?.weekOfMonth() {
            case 1:
                self.currentMonth.week1 += session.timeMeditated
            case 2:
                self.currentMonth.week2 += session.timeMeditated
            case 3:
                self.currentMonth.week3 += session.timeMeditated
            case 4:
                self.currentMonth.week4 += session.timeMeditated
            default:
                self.currentMonth.week1 += 0.0
                self.currentMonth.week2 += 0.0
                self.currentMonth.week3 += 0.0
                self.currentMonth.week4 += 0.0
            }
            
            self.currentMonthData = [
                ChartData(label: "w1", value: self.currentMonth.week1),
                ChartData(label: "w2", value: self.currentMonth.week2),
                ChartData(label: "w3", value: self.currentMonth.week3),
                ChartData(label: "w4", value: self.currentMonth.week4),
            ]
            
            for value in self.currentMonthData {
                print("label: \(value.label), value: \(value.value)")
            }
        }
    }
    
    func getYearChartData() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        let currentYearData = entities.filter({ entite in
            entite.date ?? today >= startOfYear
        })
        
        self.currentYear.jan = 0.0
        self.currentYear.feb = 0.0
        self.currentYear.mar = 0.0
        self.currentYear.apr = 0.0
        self.currentYear.may = 0.0
        self.currentYear.jun = 0.0
        self.currentYear.jul = 0.0
        self.currentYear.aug = 0.0
        self.currentYear.sep = 0.0
        self.currentYear.oct = 0.0
        self.currentYear.nov = 0.0
        self.currentYear.dec = 0.0
        
        for session in currentYearData {
            switch session.date?.monthOfYear() {
            case 1:
                self.currentYear.jan += session.timeMeditated
            case 2:
                self.currentYear.feb += session.timeMeditated
            case 3:
                self.currentYear.mar += session.timeMeditated
            case 4:
                self.currentYear.apr += session.timeMeditated
            case 5:
                self.currentYear.may += session.timeMeditated
            case 6:
                self.currentYear.jun += session.timeMeditated
            case 7:
                self.currentYear.jul += session.timeMeditated
            case 8:
                self.currentYear.aug += session.timeMeditated
            case 9:
                self.currentYear.sep += session.timeMeditated
            case 10:
                self.currentYear.oct += session.timeMeditated
            case 11:
                self.currentYear.nov += session.timeMeditated
            case 12:
                self.currentYear.dec += session.timeMeditated
            default:
                self.currentYear.jan += 0.0
                self.currentYear.feb += 0.0
                self.currentYear.mar += 0.0
                self.currentYear.apr += 0.0
                self.currentYear.may += 0.0
                self.currentYear.jun += 0.0
                self.currentYear.jul += 0.0
                self.currentYear.aug += 0.0
                self.currentYear.sep += 0.0
                self.currentYear.oct += 0.0
                self.currentYear.nov += 0.0
                self.currentYear.dec += 0.0
            }
            
            self.currentYearData = [
                ChartData(label: "j", value: self.currentYear.jan),
                ChartData(label: "f", value: self.currentYear.feb),
                ChartData(label: "m", value: self.currentYear.mar),
                ChartData(label: "a", value: self.currentYear.apr),
                ChartData(label: "m", value: self.currentYear.mar),
                ChartData(label: "j", value: self.currentYear.jun),
                ChartData(label: "j", value: self.currentYear.jul),
                ChartData(label: "a", value: self.currentYear.aug),
                ChartData(label: "s", value: self.currentYear.sep),
                ChartData(label: "o", value: self.currentYear.oct),
                ChartData(label: "n", value: self.currentYear.nov),
                ChartData(label: "d", value: self.currentYear.dec),
            ]
            
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
            self.meditatedWeek += session.timeMeditated
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
            self.meditatedTotal += entity.timeMeditated
        }
    }
    
    func getLongestSession() {
        self.coreData.getSessions()
        
        let entities = self.coreData.savedSessionEntites
        var longestSession2 = 0.0
        
        for entity in entities {
            if entity.timeMeditated >= longestSession2 {
                longestSession2 = entity.timeMeditated
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
//                print("Weekday: \(weekday)")
//                print("Previous Weekday: \(previousWeekday)")
                
                if tempStreak == 0 && previousWeekday == self.today.dayNumberOfWeek() {
                    tempStreak += 1
//                    print("tempStreak: \(tempStreak)")
                }
                
                if previousWeekday - 1 == weekday || excluded.contains(previousWeekday - 1) {
                    prev = weekday
                    tempStreak += 1
//                    print("tempStreak: \(tempStreak)")
//                    print("1st")
                    continue
                } else if previousWeekday == weekday && tempStreak == 0 {
//                    print("2nd")
                    tempStreak += 1
                    prev = weekday
//                    print("tempStreak: \(tempStreak)")
                    continue
                } else if previousWeekday == weekday {
//                    print("3rd")
                    prev = weekday
//                    print("tempStreak: \(tempStreak)")
                    continue
                } else if previousWeekday == 1 && weekday == 7 {
                    tempStreak += 1
                    prev = weekday
//                    print("4th")
//                    print("tempStreak: \(tempStreak)")
                    continue
                }
                
                
//                print("break")
                break
            }

        }
          //Change to a guard statement or similar

        
        self.streak = tempStreak
//        print("datesMeditated: \(datesMeditated)")
//        print("excluded: \(excluded)")
        
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
            currentStreak = 1
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
                    currentStreak = 1
                } else {
                    currentStreak = 1
                }
            } else if z + 1 == datesMeditated.count {
                if currentStreak > tempStreak {
                    tempStreak = currentStreak
                    currentStreak = 1
                } else {
                    currentStreak = 1
                }
            }
            
            
            self.bestStreak = tempStreak
            
            if self.streak > self.bestStreak {
                self.bestStreak = self.streak
            }
            
//            print("x: \(x)")
//            print("z: \(z)")
//            print("datesMeditated x: \(datesMeditated[x])")
//            print("datesMeditated z: \(datesMeditated[z])")
//            print("streak: \(tempStreak)")
//            print("currentStreak: \(currentStreak)")
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
            }
            
            if monGoal == true {
                
                notificationManager.createMeditationReminderMon(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("monday notification error: \(error.localizedDescription)")
                    }

                })
            }
            
            if tuesGoal == true {
                
                notificationManager.createMeditationReminderTues(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("tuesday notification error: \(error.localizedDescription)")
                    }

                })
            }
            
            if wedGoal == true {
                
                notificationManager.createMeditationReminderWed(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("wednesday notification error: \(error.localizedDescription)")
                    }

                })
            }
            
            if thurGoal == true {
                
                notificationManager.createMeditationReminderThur(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("thursday notification error: \(error.localizedDescription)")
                    }

                })
            }
            
            if friGoal == true {
                
                notificationManager.createMeditationReminderFri(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("friday notification error: \(error.localizedDescription)")
                    }

                })
            }
            
            if satGoal == true {
                
                notificationManager.createMeditationReminderSat(hour: hour, minute: minute, completion: { error in
                    if let error = error {
                        print("saturday notification error: \(error.localizedDescription)")
                    }

                })
            }
        }
    }
    
    func getChartTimes(timeRemaining: Double) -> String {
        var string = ""
        let h = Int(timeRemaining) / 3600
        let m = (Int(timeRemaining) % 3600) / 60
        
        if h != 0 {
            string = "\(h)h \(m)m"
        } else {
            string = "\(m)m"
        }
        
        
        return string
    }
    
    func timeToString(timeRemaining: Double) -> String {
        var timeRemainingString: String = ""
        
        let hours = timeRemaining/3600
        let minsMinusHours = hours.truncatingRemainder(dividingBy: 1)
        let mins = minsMinusHours * 60
        
        let wholehrs = Int(hours)
        let wholemins = Int(mins)
        
        if wholehrs > 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hrs"
        } else if wholehrs == 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hr"
        } else if wholehrs > 1 && wholemins > 1 {
            timeRemainingString = "\(wholehrs) hrs \(wholemins) mins"
        } else if wholehrs > 1 && wholemins == 1 {
            timeRemainingString = "\(wholehrs) hrs \(wholemins) min"
        } else if wholehrs == 1 && wholemins > 1 {
            timeRemainingString = "\(wholehrs) hr \(wholemins) mins"
        } else if wholehrs == 1 && wholemins == 1 {
            timeRemainingString = "\(wholehrs) hr \(wholemins) min"
        } else if wholehrs == 0 && wholemins > 1 {
            timeRemainingString = "\(wholemins) mins"
        } else if wholehrs == 0 && wholemins == 1 {
            timeRemainingString = "\(wholemins) min"
        } else {
            timeRemainingString = "\(Int(timeRemaining)) sec"
        }
        
        
        return timeRemainingString
    }
    
    
    
}

extension Calendar {
    func intervalOfWeek(for date: Date) -> DateInterval? {
    dateInterval(of: .weekOfYear, for: date)
  }
    func intervalOfMonth(for date: Date) -> DateInterval? {
        dateInterval(of: .month, for: date)
    }
    
    func intervalOfYear(for date: Date) -> DateInterval? {
        dateInterval(of: .year, for: date)
    }

    func startOfWeek(for date: Date) -> Date? {
    intervalOfWeek(for: date)?.start
  }
    
    func startOfMonth(for date: Date) -> Date? {
        intervalOfMonth(for: date)?.start
    }
    
    func startOfYear(for date: Date) -> Date? {
        intervalOfYear(for: date)?.start
    }
    
}

extension Date {
    func weekOfMonth() -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: self).weekOfMonth ?? 0
    }
    
    func monthOfYear() -> Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
}

extension ChartData: Equatable {
    static func == (lhs: ChartData, rhs: ChartData) -> Bool {
        return
            lhs.label == rhs.label &&
            lhs.value == rhs.value
    }
}
