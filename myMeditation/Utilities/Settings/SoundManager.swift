//
//  SoundManager.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/18/21.
//

import Foundation
import AVKit

enum VibrationKey {
    static let vibrationOn = "vibrationOn"
}

enum SoundKey {
    static let soundOn = "soundOn"
}

enum CompletionSound: String {
    case bowl
    case chime
    case gong
    case piano
    case zen
}

class SoundManager: ObservableObject {
    
    
    @Published var vibrationOn: Bool = UserDefaults.standard.bool(forKey: VibrationKey.vibrationOn) {
        didSet {
            UserDefaults.standard.set(self.vibrationOn, forKey: VibrationKey.vibrationOn)
        }
    }
    
    @Published var soundOn: Bool = UserDefaults.standard.bool(forKey: SoundKey.soundOn) {
        didSet {
            UserDefaults.standard.set(self.soundOn, forKey: SoundKey.soundOn)
        }
    }
    
    @Published var completionSound: CompletionSound {
        didSet {
            UserDefaults.standard.set(completionSound.rawValue, forKey: "completionSound")
        }
    }
    
    var player: AVAudioPlayer?
    
    init() {
        
        self.completionSound = (UserDefaults.standard.object(forKey: "completionSound") == nil ? CompletionSound.bowl : CompletionSound(rawValue: UserDefaults.standard.object(forKey: "completionSound") as! String)) ?? CompletionSound.bowl
    }

    func playCompletionSoundOf(sound: CompletionSound) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing completion sound. \(error.localizedDescription)")
        }
    }
    
    func playCompletionSound() {
        
        guard let url = Bundle.main.url(forResource: completionSound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing completion sound. \(error.localizedDescription)")
        }
    }
    
}
