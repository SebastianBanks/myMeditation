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
    
    //Meditation Pipeline
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
        
    }
    
    func cancel() {
        UIApplication.shared.isIdleTimerDisabled = false
        self.isMeditating = false
        self.timer.upstream.connect().cancel()
        for item in self.cancellables {
            item.cancel()
        }
    }
    
    func pauseButton() {
        UIApplication.shared.isIdleTimerDisabled = false
        print("\(pause)")
        self.pause = true

    }
    
    func start(time: Double) {
        if time > 0.0 {
            UIApplication.shared.isIdleTimerDisabled = true
            if isMeditating == false {
                self.isMeditating = true
                self.meditateTime = time
                
                meditateTimeSub()
                setUpTimer()
                timeRemainingSub()
                progressSub()
                isDoneSub()
                timeMeditatedSub()
            } else {
                self.pause = false
            }
            print("pause: \(pause)")
            print("isMeditating: \(isMeditating)")
        }

    }

    
    func meditateTimeSub() {
        $meditateTime
            .sink { completion in
                print("timeMediteSub Completion: \(completion)")
            } receiveValue: { [weak self] (value) in
                guard let self = self else { return }
                self.timeRemaining = value
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
                    print(self.timeRemaining)
                    
                    if self.timeRemaining == 0 {
                        self.cancel()
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
            }
            .store(in: &cancellables)
    }
    
    func isDoneSub() {
        $isDone
            .map { (isDone) -> Double in
                if isDone == true {
                    self.isMeditating = false
                    self.pause = false
                    print("isDone = True")
                    return self.meditateTime
                } else {
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
                    print("saved to core data and health time: \(time), bool: \(bool)")
                    self.coreData.addMeditationSession(time: time, date: self.today)
                    self.healthStore?.writeMindful(amount: time)
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
            if isMeditating == false && pause == false {
                // start meditation
                start(time: time)
            } else if isMeditating == true && pause == true {
                // resume meditation
                start(time: time)
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
