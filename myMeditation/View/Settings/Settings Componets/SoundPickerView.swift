//
//  SoundPickerView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 12/21/21.
//

import SwiftUI

struct SoundPickerView: View {
    
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @ObservedObject var soundManager = SoundManager()
    var sounds: [String] = ["TibetanBell", "Bell", "Piano", "Gong"]
    @Binding var selectedSound: String
    @Binding var showPicker: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(0..<sounds.count){ index in
                        HStack {
                            Button(action: {
                                selectedSound = sounds[index]
                                settingsViewModel.setCompletionSound(selectedSound: selectedSound)
                                soundManager.updateCompletionSound()
                                soundManager.playCompletionSound()
                                
                                print("pv selected sound: \(selectedSound)")
                                print("pv completion sound: \(soundManager.completionSound)")
                            }) {
                                HStack{
                                    Text(sounds[index])
                                        .foregroundColor(Color.init("TextColor"))
                                    Spacer()
                                    if selectedSound == sounds[index] {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.init("BarColor"))
                                    }
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button(action: {
                        showPicker = false
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            .foregroundColor(Color.init("BarColor"))
                            Text("Learn")
                                .foregroundColor(Color.init("BarColor"))
                        }
                    }
            )
            .environmentObject(settingsViewModel)
            .onAppear(perform: {
                settingsViewModel.getSelectedSound()
                selectedSound = settingsViewModel.selectedSound
            })
            .onDisappear(perform: {
                settingsViewModel.getSelectedSound()
            })
        }
        
    }
}

struct SoundPickerView_Previews: PreviewProvider {
    @State static var selectedSound: String = ""
    @State static var showPicker: Bool = false
    
    static var previews: some View {
        SoundPickerView(selectedSound: $selectedSound, showPicker: $showPicker)
    }
}
