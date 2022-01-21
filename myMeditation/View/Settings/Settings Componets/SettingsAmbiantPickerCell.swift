//
//  SettingsAmbiantPickerCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 1/20/22.
//

import SwiftUI

struct SettingsAmbiantPickerCell: View {
    
    @ObservedObject var settingsVM = SettingsViewModel()
    @StateObject var soundManager = SoundManager()
    
    var title: String
    var imgName: String
    var pickerName: String = ""
    @Binding var selectedSound: String
    
    var body: some View {
        
        HStack {
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(Color.init("BarColor"))
            
            Text(title)
                .padding(.leading, 10)
                .foregroundColor(Color.init("TextColor"))
            
            Spacer()
            
            HStack {
                Text(selectedSound)
                Image(systemName: "chevron.right")
            }
            /*
            Picker(pickerName, selection: $soundManager.completionSound, content: {
                Text("Tibetan Singing Bowl").tag(CompletionSound.bowl)
                    
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
             */
        }
        .environmentObject(soundManager)
        .onAppear(perform: {
            soundManager.updateAmbiantSound()
            settingsVM.getAmbiantSound()
            selectedSound = settingsVM.selectedAmbiantSound
        })
        .onChange(of: settingsVM.selectedAmbiantSound, perform: { value in
            print("\(value)")
            soundManager.updateAmbiantSound()
            settingsVM.getAmbiantSound()
            selectedSound = settingsVM.selectedAmbiantSound
        })
    }
}
