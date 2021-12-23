//
//  SettingsViewModel.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/4/21.
//

import Foundation
import SwiftUI
import Combine



class SettingsViewModel: ObservableObject {
    
    
    var coreHaptics: CoreHaptics?
    @ObservedObject var soundManager = SoundManager()
    @Published var selectedSound: String = ""
    var healthStore: HealthStore?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        coreHaptics = CoreHaptics()
        healthStore = HealthStore()
        getSelectedSound()
            
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
    
    func getSelectedSound() {
        
        selectedSound = UserDefaults.standard.object(forKey: "completionSound") as! String
        
    }
    
    
    func setCompletionSound(selectedSound: String) {
        switch selectedSound {
        case "TibetanBell":
            UserDefaults.standard.set(CompletionSound.TibetanBell.rawValue, forKey: "completionSound")
        case "Bell":
            UserDefaults.standard.set(CompletionSound.Bell.rawValue, forKey: "completionSound")
        case "Piano":
            UserDefaults.standard.set(CompletionSound.Piano.rawValue, forKey: "completionSound")
        case "Gong":
            UserDefaults.standard.set(CompletionSound.Gong.rawValue, forKey: "completionSound")
        default:
            print("\(selectedSound)")
        }
        
        soundManager.updateCompletionSound()
        getSelectedSound()
    }
    
//Mark: - Health
    
    func requestAuthorization() {
        healthStore?.requestAuthorization(completion: { success in
            print(success)
        })
    }
    
    
}

