//
//  MeditationViewModel.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/6/21.
//

import Foundation
import SwiftUI
import Combine
import StoreKit

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
    
    @AppStorage("reviewsRequested") var reviewsRequested = 0
    @AppStorage("stopWatchMode") var stopWatchMode = false
    
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
    @Published var stopStopWatch = false
    
    @Published var showCompletionView = false
    
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
        self.timer.upstream.connect().cancel()
        for item in self.cancellables {
            item.cancel()
        }
        resetMeditationValues()
        if soundManager.ambiantOn == true {
            soundManager.ambiantSoundStartStop(stop: true)
        }
        
        
        
    }
    
    func meditationIsOver() {
        UIApplication.shared.isIdleTimerDisabled = false
        if soundManager.ambiantOn == true {
            soundManager.ambiantSoundStartStop(stop: true)
        }
        self.isMeditatingPersist = false
        self.meditateTimePersist = 0.0
        self.timeRemainingPersist = 0.0
        self.pausePersist = false
        self.isMeditating = self.isMeditatingPersist
        self.pause = self.pausePersist
        self.progress = 0.0
        print("stopWatchMode \(self.stopWatchMode)")
        if self.stopWatchMode == true {
            self.stopStopWatch = false
            self.timeRemaining = 0.0
            print("timeRemaining: \(self.timeRemaining)")
            self.meditateTime = 0.0
        }
        self.timer.upstream.connect().cancel()
        for item in self.cancellables {
            item.cancel()
        }
    }
    
    func pauseButton() {
        UIApplication.shared.isIdleTimerDisabled = false
        print("--- pause ----")
        self.pausePersist = true
        self.pause = true
        if soundManager.ambiantOn == true {
            soundManager.ambiantSoundStartStop(stop: true)
        }
        self.timeRemainingPersist = self.timeRemaining
        print("pause: \(pause)")
        print("timeRemaingPersist: \(timeRemainingPersist)")
        print("pausePersist: \(pausePersist)")
    }
    func saveTimeRemaining(timeRemaining: Double) {
        self.timeRemainingPersist = timeRemaining
    }
    func appEnteredBackground(isMeditating: Bool) {
        
        if self.isMeditating == true && self.pause == false {
            pauseButton()
            
            self.isMeditatingPersist = isMeditating
            self.meditateTimePersist = self.meditateTime
            self.timeRemainingPersist = self.timeRemaining
            self.pausePersist = true
            self.pause = true
            if soundManager.ambiantOn == true {
                soundManager.ambiantSoundStartStop(stop: true)
            }
            
            print("----Background----")
            print("isMeditaingPersist: \(self.isMeditatingPersist)")
            print("meditateTimePersist: \(self.meditateTimePersist)")
            print("timeRemainingPersist: \(self.timeRemainingPersist)")
            print("pausePersist: \(self.pausePersist)")
        }
        
    }
    
    func appEnteredForeground() {
        if self.isMeditatingPersist == true {
            UIApplication.shared.isIdleTimerDisabled = false
            self.timer.upstream.connect().cancel()
            for item in self.cancellables {
                item.cancel()
            }
            self.pausePersist = true
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
        self.timeRemaining = self.timeRemainingPersist
        self.pause = self.pausePersist
        self.progress = 0.0
        self.isDone = false
        self.stopStopWatch = false
    }
    
    func isMeditatingOnDisappear(isMeditating: Bool) {
        print("---- Disappear ---")
        if isMeditating == true {
            UIApplication.shared.isIdleTimerDisabled = false
            self.timer.upstream.connect().cancel()
            for item in self.cancellables {
                item.cancel()
            }
            self.isMeditatingPersist = true
            self.isMeditating = true
            self.pausePersist = true
            self.pause = true
            self.timeRemainingPersist = self.timeRemaining
            if soundManager.ambiantOn == true {
                soundManager.ambiantSoundStartStop(stop: true)
            }
        }
        
        print("isMeditating Persist: \(self.isMeditatingPersist)")
        print("isMeditating: \(self.isMeditating)")
        print("pausePersist: \(self.pausePersist)")
        print("pause: \(self.pause)")
        print("meditateTimePersist:\(self.meditateTimePersist)")
    }
    
//    make it so timeRemainingPersist does't change when timeRemaining changes
//    figure out how
    func start(time: Double) {
        if time > 0.0 {
            if isMeditatingPersist == false && isMeditating == false {
                print("---- 1st start -----")
                UIApplication.shared.isIdleTimerDisabled = true
                self.isMeditating = true
                self.isMeditatingPersist = true
                self.meditateTime = time
                self.meditateTimePersist = time
                if soundManager.ambiantOn == true {
                    soundManager.ambiantSoundStartStop(stop: false)
                }
                if self.stopWatchMode == false {
                    meditateTimeSub()
                } else {
                    self.timeRemaining = 0.0
                }
                
                setUpTimer()
                timeRemainingSub()
                progressSub()
                isDoneSub()
                timeMeditatedSub()
            } else if isMeditatingPersist == true && pausePersist == true {
                print("---- 2nd start -----")
                self.timer.upstream.connect().cancel()
                for item in self.cancellables {
                    item.cancel()
                }
                UIApplication.shared.isIdleTimerDisabled = true
                self.pause = false
                self.pausePersist = false
                self.meditateTime = self.meditateTimePersist
                self.timeRemaining = self.timeRemainingPersist
                self.isMeditating = true
                if soundManager.ambiantOn == true {
                    soundManager.ambiantSoundStartStop(stop: false)
                }
                    
                setUpTimer()
                timeRemainingSub()
                progressSub()
                isDoneSub()
                timeMeditatedSub()
            } else {
                print("---- 3rd start -----")
                self.timer.upstream.connect().cancel()
                for item in self.cancellables {
                    item.cancel()
                }
                    
                UIApplication.shared.isIdleTimerDisabled = true
                self.meditateTime = self.meditateTimePersist
                self.timeRemaining = self.timeRemainingPersist
                self.isMeditating = true
                self.pause = false
                self.pausePersist = false
                if soundManager.ambiantOn == true {
                    soundManager.ambiantSoundStartStop(stop: false)
                }
                    
                setUpTimer()
                timeRemainingSub()
                progressSub()
                isDoneSub()
                timeMeditatedSub()
            }
            print("pause: \(pause)")
            print("isMeditating: \(isMeditating)")
            print("time: \(time)")
            print("meditateTime: \(meditateTime)")
        } else {
            print("something unexpected happened, time is 0.0")
        }
    }

    
    func meditateTimeSub() {
        $meditateTime
            .sink { completion in
                print("timeMediteSub Completion: \(completion)")
            } receiveValue: { [weak self] (value) in
                guard let self = self else { return }
                if self.stopWatchMode == false {
                    self.timeRemaining = value
                } else {
                    self.timeRemaining = 0.0
                }
                
            }
            .store(in: &cancellables)

    }
    
    func setUpTimer() {
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.pausePersist == false {
                    if self.stopWatchMode == false {
                        print("pause: \(self.pause)")
                        self.timeRemaining -= 1
                        self.saveTimeRemaining(timeRemaining: self.timeRemaining)
                        print(self.timeRemaining)
                        
                        if self.timeRemaining == 0.0 {
                            self.meditationIsOver()
                        }
                    } else {
                        print("pause: \(self.pause)")
                        self.timeRemaining += 1
                        self.saveTimeRemaining(timeRemaining: self.timeRemaining)
                        print(self.timeRemaining)
                        
                        if self.stopStopWatch == true {
                            self.meditationIsOver()
                        }
                    }
                    
                } else {
                    print("pause: \(self.pause)")
                    self.timeRemaining = self.timeRemaining
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
                if self.stopWatchMode == false {
                    if timeRemaining == 0 {
                        return true
                    } else {
                        return false
                    }
                } else {
                    if self.stopStopWatch == true {
                        return true
                    } else {
                        return false
                    }
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
                if isDone == true && self.pausePersist == false {
                    if self.stopWatchMode == false {
                        self.isMeditating = false
                        self.isMeditatingPersist = false
                        self.timeRemainingPersist = 0.0
                        self.pause = false
                        self.pausePersist = false
                        print("isDone = True")
                        print("1 meditateTime: \(self.meditateTime)")
                        return self.meditateTime
                    } else {
                        self.isMeditating = false
                        self.isMeditatingPersist = false
                        self.meditateTime = 0.0
                        self.pause = false
                        self.pausePersist = false
                        print("isDone = True")
                        print("1 timeRemaining: \(self.timeRemaining)")
                        return self.timeRemaining
                    }
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
                        self.showCompletionView = true
                        self.meditationIsOver()
                    }
                    UIApplication.shared.isIdleTimerDisabled = false
                } else {
                    print("not saved time: \(time) bool: \(bool)")
                }
                
            }
            .store(in: &cancellables)
    }
    
    func getStopWatchText(timeRemaing: Double) -> String {
        var string = ""
        let h = Int(timeRemaing) / 3600
        let m = (Int(timeRemaing) % 3600) / 60
        let s = (Int(timeRemaing) % 3600) % 60
        string = " \(h) : \(m) : \(s) "
        
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
    
    func startPauseButton(time: Double) {
        if time > 0.0 {
            if isMeditating == false && pause == false {
                // start meditation
                print("---- start meditation ----")
                start(time: time)
            } else if isMeditatingPersist == true && pausePersist == true {
                // resume meditation
                print("---- resume meditation ----")
                start(time: self.timeRemainingPersist)
            } else {
                // pause meditation
                print("---- pause meditation ----")
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
    
    func requestReviewIfNeeded() {
        var meditationsCompleted = 0
        
        for _ in coreData.savedSessionEntites {
            meditationsCompleted += 1
        }
        
        if self.reviewsRequested == 0 && meditationsCompleted >= 3 && meditationsCompleted < 25{
            self.reviewsRequested += 1
            if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if self.reviewsRequested == 1 && meditationsCompleted >= 30 && meditationsCompleted < 75{
            self.reviewsRequested += 1
            if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if self.reviewsRequested == 2 && meditationsCompleted >= 80{
            self.reviewsRequested += 1
            if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
