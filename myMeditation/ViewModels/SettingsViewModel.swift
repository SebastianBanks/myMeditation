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
    var statusImage: Image = Image(systemName: "questionMark")
    @AppStorage("buddhaMode", store: .standard) var buddhaModeOn: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        coreHaptics = CoreHaptics()
        healthStore = HealthStore()
        getSelectedSound()
        self.statusImage = returnImageStatus()
    }
    
    func getIsOn(key: String) -> Binding<Bool> {
        
        switch key {
        case SoundKey.soundOn:
            return self.$soundManager.soundOn
        case VibrationKey.vibrationOn:
            return self.$soundManager.vibrationOn
        case "buddhaMode":
            return self.$buddhaModeOn
        default:
            print("key not identified")
            return self.$soundManager.soundOn
        }
    }
    
    func getSelectedSound() {
        
        if UserDefaults.standard.object(forKey: "completionSound") != nil {
            selectedSound = UserDefaults.standard.object(forKey: "completionSound") as! String
        } else {
            selectedSound = ""
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
        getSelectedSound()
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

