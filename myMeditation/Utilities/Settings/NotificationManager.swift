//
//  NotificationManager.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/6/21.
//

import Foundation
import UserNotifications
import SwiftUI
import Combine

enum notificationKeys {
    static let notificationsOn = "notificationsOn"
    static let meditationReminderOn = "meditationReminderOn"
    static let mindfulMotivationOn = "mindfulMotivationOn"
}

class NotificationManager: ObservableObject {
    
    @Published var notificationsOn: Bool = UserDefaults.standard.bool(forKey: notificationKeys.notificationsOn) {
        didSet {
            UserDefaults.standard.set(self.notificationsOn, forKey: notificationKeys.notificationsOn)
        }
    }
    
    @Published var meditationReminderOn: Bool = UserDefaults.standard.bool(forKey: notificationKeys.meditationReminderOn) {
        didSet {
            UserDefaults.standard.set(self.meditationReminderOn, forKey: notificationKeys.meditationReminderOn)
        }
    }
    
    @Published var mindfulMotivationOn: Bool = UserDefaults.standard.bool(forKey: notificationKeys.mindfulMotivationOn) {
        didSet {
            UserDefaults.standard.set(self.mindfulMotivationOn, forKey: notificationKeys.mindfulMotivationOn)
        }
    }
    
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    
    init() {
        setNotificationStatus()
    }
    
    func getIsOn(key: String) -> Bool {
        
        switch key {
        case notificationKeys.notificationsOn:
            return self.notificationsOn
        case notificationKeys.meditationReminderOn:
            return self.meditationReminderOn
        case notificationKeys.mindfulMotivationOn:
            return self.mindfulMotivationOn
        default:
            print("key not identified")
            return self.notificationsOn
        }
    }
    
    
    func getStatusSetToggle(isOn: Bool, key: String) {
        
        switch key {
        case notificationKeys.notificationsOn:
            if isOn == true {
                self.notificationsOn = isOn
                if authorizationStatus == .notDetermined {
                    requestAuthorization()
                } else if authorizationStatus == .denied {
                    notificationsOn = false
                    meditationReminderOn = false
                    mindfulMotivationOn = false
                } else {
                    reloadNotifications()
                    updateToggles()
                    
                    for notification in notifications {
                        print(notification.content.body)
                        print(notification.trigger ?? "error")
                    }
                }
            } else {
                self.notificationsOn = isOn
                deleteNotifications()
            }
        case notificationKeys.meditationReminderOn:
            if isOn == true {
                self.meditationReminderOn = isOn
                if authorizationStatus == .notDetermined {
                    requestAuthorization()
                } else if authorizationStatus == .denied {
                    notificationsOn = false
                    meditationReminderOn = false
                    mindfulMotivationOn = false
                } else {
                    updateToggles()
                    reloadNotifications()
                }
            } else {
                deleteReminderNotification()
            }
        case notificationKeys.mindfulMotivationOn:
            if isOn == true {
                self.mindfulMotivationOn = isOn
                if authorizationStatus == .notDetermined {
                    requestAuthorization()
                } else if authorizationStatus == .denied {
                    self.notificationsOn = false
                    self.meditationReminderOn = false
                    self.mindfulMotivationOn = false
                } else if authorizationStatus == .authorized {
                    deleteMindfulMotivationNotifications()
                    createMotivationNotification(completion: { error in
                        if let error = error {
                            print(error)
                        }
                    })
                    reloadNotifications()
                        
                }
            } else {
                self.mindfulMotivationOn = isOn
                deleteMindfulMotivationNotifications()
                reloadNotifications()
            }
        default:
            print("Uh oh, key was not recognized")
            notificationsOn = false
            meditationReminderOn = false
            mindfulMotivationOn = false
            
        }
            
    }
    
    func setNotificationStatus() {
        if notificationsOn == false {
            deleteNotifications()
        } else {
            reloadNotifications()
        }
        
    }
    
    func updateToggles() {
        self.notificationsOn = notificationsOn
        self.meditationReminderOn = meditationReminderOn
        self.mindfulMotivationOn = mindfulMotivationOn
        
        if meditationReminderOn || mindfulMotivationOn == true {
            self.notificationsOn = true
            self.meditationReminderOn = meditationReminderOn
            self.mindfulMotivationOn = mindfulMotivationOn
        } else {
            self.notificationsOn = notificationsOn
            self.meditationReminderOn = meditationReminderOn
            self.mindfulMotivationOn = mindfulMotivationOn
        }
    }
    
/*
    func getIsOnState(key: String) -> Binding<Bool> {
        
        switch key {
        case notificationKeys.notificationsOn:
            return shared.$notificationsOn
        case notificationKeys.meditationReminderOn:
            return shared.meditationReminderOn
        case notificationKeys.mindfulMotivationOn:
            return shared.mindfulMotivationOn
        default:
            print("key not identified")
            return shared.$notificationsOn
        }
    }
*/
    
    
    func reloadAuthorizationStatus() {
         UNUserNotificationCenter.current().getNotificationSettings { settings in DispatchQueue.main.async {
            self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func denyAuthorization() {
        DispatchQueue.main.async { [self] in
            self.authorizationStatus = .denied
            }
        
    }
    
    func deleteReminderNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ReminderSun", "ReminderMon", "ReminderTues", "ReminderWed", "ReminderThur", "ReminderFri", "ReminderSat", "Reminder"])
    }
    
    func deleteMindfulMotivationNotifications() {
        for quote in quotes {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [quote.id])
        }
    }
    
    func deleteNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    
    func reloadNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notification in
            DispatchQueue.main.async {
                self.notifications = notification
            }
            
        }
    }
    
    func createMotivationNotification(completion: @escaping (Error?) -> Void) {
        
        deleteMindfulMotivationNotifications()
        reloadNotifications()
        
        for quote in quotes {
            var dateComponets = DateComponents()
            dateComponets.hour = quote.hour
            dateComponets.day = quote.day
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
            
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "☸︎ Mindful Motivation ☯︎"
            notificationContent.body = quote.body
            notificationContent.sound = .default
            
            if #available(iOS 15.0, *) {
                notificationContent.interruptionLevel = .passive
            } else {
                // Fallback on earlier versions
            }
        
        
            let request = UNNotificationRequest(identifier: quote.id, content: notificationContent, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
        }
        
    }
    
    func createMeditationReminderSun(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        /* To add to button in view:
         
         let dateComponets = Calander.current.dateComponets([.weekDay, .hour, .minute], from: date)
         guard let day = dateComponets.day, hour = dateComponets.hour, let minute = dateComponets.minute else { return }
         
         notificationManager.createMeditationReminder(day: day, hour: hour, minute: minute, completion: { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.isPresented = false
                    // using this to dismiss the sheet after notification is added
         
                    }
         
         .onDisapper {
            notificationManager.reloadLocalNotification()
         }
         
         
         You will use this when user wants to create meditation reminder
         */
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 1
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderSun", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderMon(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 2
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderMon", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderTues(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 3
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderTues", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderWed(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 4
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderWed", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderThur(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 5
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderThur", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderFri(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 6
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderFri", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createMeditationReminderSat(hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        var dateComponets = DateComponents()
        dateComponets.weekday = 7
        dateComponets.hour = hour
        dateComponets.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Meditation Reminder ⏰"
        notificationContent.body = "Take a moment for yourself and reset your mind and body. 🧘"
        notificationContent.sound = .default
        if #available(iOS 15.0, *) {
            notificationContent.interruptionLevel = .timeSensitive
        } else {
            // Fallback on earlier versions
        }
        
        let request = UNNotificationRequest(identifier: "ReminderSat", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
}


