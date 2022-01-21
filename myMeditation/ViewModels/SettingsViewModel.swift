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
    @Published var selectedCompletionSound: String = ""
    @Published var selectedAmbiantSound: String = ""
    var healthStore: HealthStore?
    var statusImage: Image = Image(systemName: "questionMark")
    @AppStorage("buddhaMode", store: .standard) var buddhaModeOn: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        coreHaptics = CoreHaptics()
        healthStore = HealthStore()
        getCompletionSound()
        getAmbiantSound()
        self.statusImage = returnImageStatus()
    }
    
    func getIsOn(key: String) -> Binding<Bool> {
        
        switch key {
        case SoundKey.soundOn:
            return self.$soundManager.soundOn
        case VibrationKey.vibrationOn:
            return self.$soundManager.vibrationOn
        case AmbiantKey.ambiantOn:
            return self.$soundManager.ambiantOn
        case "buddhaMode":
            return self.$buddhaModeOn
        default:
            print("key not identified")
            return self.$soundManager.soundOn
        }
    }
    
    func getCompletionSound() {
        
        if UserDefaults.standard.object(forKey: "completionSound") != nil {
            selectedCompletionSound = UserDefaults.standard.object(forKey: "completionSound") as! String
        } else {
            selectedCompletionSound = ""
        }
    }
    
    func getAmbiantSound() {
        
        if UserDefaults.standard.object(forKey: "ambiantSound") != nil {
            selectedAmbiantSound = UserDefaults.standard.object(forKey: "ambiantSound") as! String
        } else {
            selectedAmbiantSound = ""
        }
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
        getCompletionSound()
    }
    
    func setAmbiantSound(selectedSound: String) {
        switch selectedSound {
        case "Ocean":
            UserDefaults.standard.set(AmbiantSound.Ocean.rawValue, forKey: "ambiantSound")
        case "Rain":
            UserDefaults.standard.set(AmbiantSound.Rain.rawValue, forKey: "ambiantSound")
        case "Stream":
            UserDefaults.standard.set(AmbiantSound.Stream.rawValue, forKey: "ambiantSound")
        case "Fire":
            UserDefaults.standard.set(AmbiantSound.Fire.rawValue, forKey: "ambiantSound")
        case "Birds":
            UserDefaults.standard.set(AmbiantSound.Birds.rawValue, forKey: "ambiantSound")
        default:
            print("selectedSound not found \(selectedSound)")
        }
        
        soundManager.updateAmbiantSound()
        getAmbiantSound()
    }
    
//Mark: - Health
    
    func requestAuthorization() {
        healthStore?.requestAuthorization(completion: { success in
            print(success)
        })
        
        healthStore?.updateHealthStatus()
    }
    
    func updateStatusImage() {
        healthStore?.updateHealthStatus()
        self.statusImage = returnImageStatus()
    }
    
    func returnImageStatus() -> Image {
        healthStore?.updateHealthStatus()
        
        switch healthStore?.status {
        case .sharingAuthorized:
            return Image(systemName: "checkmark")
        case .sharingDenied:
            return Image(systemName: "xmark")
        default:
            return Image(systemName: "questionmark")
        }
    }
    
    func addImageModifiers(image: Image) -> some View {
        healthStore?.updateHealthStatus()
        
        switch healthStore?.status {
        case .notDetermined:
            return image
                .font(.headline)
                .foregroundColor(Color.init("TextColor"))
        case .sharingAuthorized:
            return image
                .font(.headline)
                .foregroundColor(.green)
        case .sharingDenied:
            return image
                .font(.headline)
                .foregroundColor(.red)
        default:
            return image
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
    
    func openURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

