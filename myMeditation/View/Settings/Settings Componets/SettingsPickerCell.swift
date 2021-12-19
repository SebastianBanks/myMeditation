//
//  SettingsPickerCell.swift
//  UserDefaultsPractice
//
//  Created by Sebastian Banks on 10/1/21.
//

import SwiftUI


struct SettingsPickerCell: View {
    
    @StateObject var soundManager = SoundManager()
    
    var title: String
    var imgName: String
    var pickerName: String = ""
    
    
    var body: some View {
        
        HStack {
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(Color.init("BarColor"))
            
            Text(title)
                .padding(.leading, 10)
                .foregroundColor(Color.init("TextColor"))
            
            Spacer()
            
            Picker(pickerName, selection: $soundManager.completionSound, content: {
                Text("Tibetan Singing Bowl").tag(CompletionSound.bowl)
                    .onTapGesture {
                        if soundManager.soundOn == true {
                            soundManager.playCompletionSoundOf(sound: CompletionSound.bowl)
                        }
                    }
                Text("Chime").tag(CompletionSound.chime)
                    .onTapGesture {
                        if soundManager.soundOn == true {
                            soundManager.playCompletionSoundOf(sound: CompletionSound.chime)
                        }
                    }
                Text("Gong").tag(CompletionSound.gong)
                    .onTapGesture {
                        if soundManager.soundOn == true {
                            soundManager.playCompletionSoundOf(sound: CompletionSound.gong)
                        }
                    }
                Text("Piano").tag(CompletionSound.piano)
                    .onTapGesture {
                        if soundManager.soundOn == true {
                            soundManager.playCompletionSoundOf(sound: CompletionSound.piano)
                        }
                    }
                Text("Zen").tag(CompletionSound.zen)
                    .onTapGesture {
                        if soundManager.soundOn == true {
                            soundManager.playCompletionSoundOf(sound: CompletionSound.zen)
                        }
                    }
                
            })

        }
        .environmentObject(soundManager)
    }
}



