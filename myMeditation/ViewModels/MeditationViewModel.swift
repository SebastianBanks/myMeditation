//
//  MeditationViewModel.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/6/21.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 15, *)
class MeditationViewModel: ObservableObject {
    //UserDefaults
    @ObservedObject var soundManager = SoundManager()
    var healthStore: HealthStore?
    
    //Session - core data
    @ObservedObject var coreData = CoreData()
    
    /*
     @Published var vibrationOn: Bool = UserDefaults.standard.bool(forKey: VibrationKey.vibrationOn) {
         didSet {
             UserDefaults.standard.set(self.vibrationOn, forKey: VibrationKey.vibrationOn)
         }
     }
     */
    
    enum meditationValues {
        static let isMeditating = "isMeditating"
        static let meditateTime = "meditateTime"
        static let timeRemaining = "timeRemaining"
        static let progress = "progress"
        static let isDone = "isDone"
        static let timeMeditated = "timeMeditated"
    }
    
    //Meditation Pipeline
    @AppStorage("isMeditating", store: .standard) var isMeditatingPersist: Bool = false
    @AppStorage("meditateTime", store: .standard) var meditateTimePersist: Double = 0.0
    @AppStorage("timeRemaining", store: .standard) var timeRemainingPersist: Double = 0.0
    @AppStorage("pause", store: .standard) var pausePersist: Bool = false
    
    @Published var isMeditating: Bool = false
    @Published var meditateTime: Double = 0.0
    @Published var timeRemaining: Double = 0.0
    @Published var progress: Float = 0.0
    @Published var isDone: Bool = false
    @Published var timeMeditated = 0.0
    
    var pause: Bool = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var cancellables = Set<AnyCancellable>()
    
    let calendar = Calendar.current
    let today: Date
    var progressText: String = ""
    
    @AppStorage("meditateHourPicker", store: .standard) var meditateHourPicker: Int = 0
    @AppStorage("meditateMinPicker", store: .standard) var meditateMinPicker: Int = 5
    
    
    init() {
        healthStore = HealthStore()
        today = calendar.startOfDay(for: Date())
        
        if self.isMeditatingPersist == false {
            self.pausePersist = false
        }
        
        self.isMeditating = self.isMeditatingPersist
        self.meditateTime = self.meditateTimePersist
        self.timeRemaining = self.timeRemainingPersist
        self.pause = self.pausePersist
    }
    
    func cancel() {
        UIApplication.shared.isIdleTimerDisabled = false
        self.isMeditating = false
        self.isMeditatingPersist = false
        self.pause = false
        self.timer.upstream.connect().cancel()
        for item in self.cancellables {
            item.cancel()
        }
    }
    
    func pauseButton() {
        UIApplication.shared.isIdleTimerDisabled = false
        print("pause before: \(pause)")
        self.pause = true
        print("pause after: \(pause)")
    }
    
    func appEnteredBackground(isMeditating: Bool) {
        
        if self.isMeditating == true && self.pause == false {
            pauseButton()
            
            self.isMeditatingPersist = isMeditating
            self.meditateTimePersist = self.meditateTime
            self.timeRemainingPersist = self.timeRemaining
            self.pausePersist = true
            
            print("----Background----")
            print("isMeditaingPersist: \(self.isMeditatingPersist)")
            print("meditateTimePersist: \(self.meditateTimePersist)")
            print("timeRemainingPersist: \(self.timeRemainingPersist)")
            print("pausePersist: \(self.pausePersist)")
        }
        
    }
    
    func appEnteredForeground() {
        if self.isMeditatingPersist == true {
            self.meditateTime = self.meditateTimePersist
            self.timeRemaining = self.timeRemainingPersist
            self.pause = self.pausePersist
            self.progress = Float(timeRemaining/meditateTime)
            self.progressText = self.timeToString(timeRemaining: timeRemaining)
            
            print("----Foreground----")
            print("meditateTime: \(self.meditateTime)")
            print("isMeditating: \(self.isMeditatingPersist)")
            print("timeRemaing: \(self.timeRemaining)")
            print("pause: \(self.pause)")
        }
        
    }
    
    func resetMeditationValues() {
        self.isMeditatingPersist = false
        self.meditateTimePersist = 0.0
        self.timeRemainingPersist = 0.0
        self.pausePersist = false
        self.isMeditating = self.isMeditatingPersist
        self.meditateTime = self.meditateTimePersist
        self.timeRemaining = self.timeRemainingPersist
        self.pause = self.pausePersist
    }
    
//    make it so timeRemainingPersist does't change when timeRemaining changes
//    figure out how
    func start(time: Double) {
        if time > 0.0 {
                UIApplication.shared.isIdleTimerDisabled = true
                if isMeditatingPersist == false {
                    print("---- 1st start -----")
                    self.isMeditating = true
                    self.meditateTime = time
                    self.meditateTimePersist = time
                    
                    meditateTimeSub()
                    setUpTimer()
                    timeRemainingSub()
                    progressSub()
                    isDoneSub()
                    timeMeditatedSub()
                } else if isMeditatingPersist == true && isMeditating == true {
                    print("---- 2nd start -----")
                    self.pause = false
                    self.pausePersist = false
                    self.meditateTime = self.meditateTimePersist
                    self.timeRemaining = self.timeRemainingPersist
                    self.isMeditating = true
                    
                    setUpTimer()
                    timeRemainingSub()
                    progressSub()
                    isDoneSub()
                    timeMeditatedSub()
                } else {
                    print("---- 3rd start -----")
                    self.pause = false
                    self.pausePersist = false
                }
                print("pause: \(pause)")
                print("isMeditating: \(isMeditating)")
                print("time: \(time)")
                print("meditateTime: \(meditateTime)")
            }
        }

    
    func meditateTimeSub() {
        $meditateTime
            .sink { completion in
                print("timeMediteSub Completion: \(completion)")
            } receiveValue: { [weak self] (value) in
                guard let self = self else { return }
                self.timeRemaining = value
                self.timeRemainingPersist = value
            }
            .store(in: &cancellables)

    }
    
    func setUpTimer() {
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.pause == false {
                    print("pause: \(self.pause)")
                    self.timeRemaining -= 1
                    self.timeRemainingPersist = self.timeRemaining
                    print(self.timeRemaining)
                    
                    if self.timeRemaining == 0.0 {
                        self.cancel()
                    }
                } else {
                    print("pause: \(self.pause)")
                    self.timeRemaining = self.timeRemaining
                    self.timeRemainingPersist = self.timeRemaining
                    self.progress = self.progress
                }
                

            }.store(in: &cancellables)
        
    }
    
    func timeRemainingSub() {
        $timeRemaining
            .combineLatest($meditateTime)
            .sink { completion in
                print("Set Progress completion: \(completion)")
            } receiveValue: { [weak self] (timeRemaining, meditateTime) in
                guard let self = self else { return }
                self.progress = Float(timeRemaining/meditateTime)
                self.progressText = self.timeToString(timeRemaining: timeRemaining)
                print("progress: \(self.progress)")
            }
            .store(in: &cancellables)

    }
    
    func progressSub() {
        $progress
            .map{ (timeRemaining) -> Bool in
                if timeRemaining == 0 {
                    return true
                } else {
                    return false
                }
            }
            .sink { completion in
                print("progressSub completion: \(completion)")
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.isDone = value
                print("isDone: \(self.isDone)")
            }
            .store(in: &cancellables)
    }
    
    func isDoneSub() {
        $isDone
            .map { (isDone) -> Double in
                if isDone == true && self.pausePersist == false{
                    self.isMeditating = false
                    self.isMeditatingPersist = false
                    self.pause = false
                    self.pausePersist = false
                    print("isDone = True")
                    print("1 meditateTime: \(self.meditateTime)")
                    return self.meditateTime
                } else {
                    print("2 meditateTime: \(self.meditateTime)")
                    return 0.0
                }
            }
            .sink { completion in
                print("isDoneSub Completion: \(completion)")
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.timeMeditated = value
                print("timeMeditated: \(self.timeMeditated)")
            }
            .store(in: &cancellables)

    }
    
    func timeMeditatedSub() {
        $timeMeditated
            .combineLatest($isDone)
            .sink { completion in
                print("timeMeditatedSub Completion: \(completion)")
            } receiveValue: { [weak self] (time, bool) in
                guard let self = self else { return }
                if bool == true {
                    if time > 0.0 && self.isMeditatingPersist == false {
                        print("saved to core data and health time: \(time), bool: \(bool)")
                        self.coreData.addMeditationSession(time: time, date: self.today)
                        self.healthStore?.writeMindful(amount: time)
                    }
                    UIApplication.shared.isIdleTimerDisabled = false
                } else {
                    print("not saved time: \(time) bool: \(bool)")
                }
                
            }
            .store(in: &cancellables)
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
        } else if wholehrs > 1 && wholemins >= 1{
            timeRemainingString = "\(wholehrs) hrs \(wholemins) mins"
        } else if wholehrs == 0 && wholemins >= 1{
            timeRemainingString = "\(wholemins) mins"
        } else {
            timeRemainingString = "\(Int(timeRemaining)) sec"
        }
        
        
        return timeRemainingString
    }
    
    func startPauseButton(time: Double) {
        if time > 0.0 {
            if isMeditatingPersist == false && pausePersist == false {
                // start meditation
                start(time: time)
            } else if isMeditatingPersist == true && pausePersist == true {
                // resume meditation
                start(time: self.timeRemainingPersist)
            } else {
                // pause meditation
                pauseButton()
            }
        }
        
    }
    
    func startPauseString() -> String {
        if isMeditating == false  && pause == false {
            return "Start"
        } else if isMeditating == true && pause == true {
            return "Start"
        } else {
            return "Pause"
        }
    }
    
    
}
