//
//  SettingsViewModel.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/4/21.
//

import Foundation
import SwiftUI



class SettingsViewModel: ObservableObject {
    
    
    var coreHaptics: CoreHaptics?
    @ObservedObject var soundManager = SoundManager()
    var healthStore: HealthStore?
    
    init() {
        coreHaptics = CoreHaptics()
        healthStore = HealthStore()
            
    }
    
    func getIsOn(key: String) -> Binding<Bool> {
        
        switch key {
        case SoundKey.soundOn:
            return self.$soundManager.soundOn
        case VibrationKey.vibrationOn:
            return self.$soundManager.vibrationOn
        default:
            print("key not identified")
            return self.$soundManager.soundOn
        }
    }
    
//Mark: - Health
    
    func requestAuthorization() {
        healthStore?.requestAuthorization(completion: { success in
            print(success)
        })
    }
    
    
}

