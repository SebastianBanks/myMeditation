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
    case TibetanBell
    case Bell
    case Gong
    case Piano
}

enum AmbiantKey {
    static let ambiantOn = "ambiantOn"
}

enum AmbiantSound: String {
    case Rain
    case Stream
    case Ocean
    case Fire
    case Birds
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
    
    @Published var ambiantOn: Bool = UserDefaults.standard.bool(forKey: AmbiantKey.ambiantOn) {
        didSet {
            UserDefaults.standard.set(self.ambiantOn, forKey: AmbiantKey.ambiantOn)
        }
    }
    
    @Published var ambiantSound: AmbiantSound {
        didSet {
            UserDefaults.standard.set(ambiantSound.rawValue, forKey: "ambiantSound")
        }
    }
    
    var player: AVAudioPlayer?
    var coreHaptics = CoreHaptics()
    
    init() {
        
        self.completionSound = (UserDefaults.standard.object(forKey: "completionSound") == nil ? CompletionSound.Gong : CompletionSound(rawValue: UserDefaults.standard.object(forKey: "completionSound") as! String)) ?? CompletionSound.Gong
        
        self.ambiantSound = (UserDefaults.standard.object(forKey: "ambiantSound") == nil ? AmbiantSound.Ocean : AmbiantSound(rawValue: UserDefaults.standard.object(forKey: "ambiantSound") as! String)) ?? AmbiantSound.Ocean
    }
    
    func updateCompletionSound() {
        if UserDefaults.standard.object(forKey: "completionSound") != nil {
            self.completionSound = CompletionSound(rawValue: UserDefaults.standard.object(forKey: "completionSound") as! String) ?? CompletionSound.Gong
        } else {
            print("there was an error updating completion sound")
        }
    }
    
    func updateAmbiantSound() {
        if UserDefaults.standard.object(forKey: "ambiantSound") != nil {
            self.ambiantSound = AmbiantSound(rawValue: UserDefaults.standard.object(forKey: "ambiantSound") as! String) ?? AmbiantSound.Ocean
        } else {
            print("there was an error updating ambiant sound")
        }
    }
    
    func playAmbiantSoundOf(sound: AmbiantSound) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing ambiant sound. \(error.localizedDescription)")
        }
        
    }
    
    func playAmbiantSound(turnAmbiantOff: Bool) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        guard let url = Bundle.main.url(forResource: ambiantSound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            if turnAmbiantOff == true {
                player?.stop()
            }
        } catch let error {
            print("Error playing ambiant sound. \(error.localizedDescription)")
        }

    }

    func playCompletionSoundOf(sound: CompletionSound) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
            if self.vibrationOn == true {
                switch sound {
                case .TibetanBell:
                    coreHaptics?.playHapticsFile(named: "TibetanBellAhap")
                case .Bell:
                    coreHaptics?.playHapticsFile(named: "BellAhap")
                case .Gong:
                    coreHaptics?.playHapticsFile(named: "GongAhap")
                case .Piano:
                    coreHaptics?.playHapticsFile(named: "PianoAhap")
                }
            }
            
            
            
        } catch let error {
            print("Error playing completion sound. \(error.localizedDescription)")
        }
    }
    
    
    func playCompletionSound() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let url = Bundle.main.url(forResource: completionSound.rawValue, withExtension: ".wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            if self.vibrationOn == true {
                switch completionSound {
                case .TibetanBell:
                    coreHaptics?.playHapticsFile(named: "TibetanBellAhap")
                case .Bell:
                    coreHaptics?.playHapticsFile(named: "BellAhap")
                case .Gong:
                    coreHaptics?.playHapticsFile(named: "GongAhap")
                case .Piano:
                    coreHaptics?.playHapticsFile(named: "PianoAhap")
                }
            }
           
        } catch let error {
            print("Error playing completion sound. \(error.localizedDescription)")
        }
    }
    
}
