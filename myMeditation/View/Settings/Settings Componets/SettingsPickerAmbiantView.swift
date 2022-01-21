//
//  SettingsPickerAmbiantView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 1/20/22.
//

import SwiftUI

struct SettingsPickerAmbiantView: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @ObservedObject var soundManager = SoundManager()
    var ambiantSounds: [String] = ["Ocean", "Fire", "Stream", "Birds", "Rain"]
    @Binding var selectedAmbiantSound: String
    @Binding var showPicker: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(0..<ambiantSounds.count){ index in
                        HStack {
                            Button(action: {
                                print("ambiantButtonPressed")
                                selectedAmbiantSound = ambiantSounds[index]
                                print("selectedAmbiantSound: \(selectedAmbiantSound)")
                                settingsViewModel.setAmbiantSound(selectedSound: selectedAmbiantSound)
                                print("set ambiant sound works")
                                soundManager.updateAmbiantSound()
                                print("update ambiant sound works")
                                soundManager.playAmbiantSound()
                                
                                print("pv selected sound: \(selectedAmbiantSound)")
                                print("pv completion sound: \(soundManager.ambiantSound)")
                            }) {
                                HStack{
                                    Text(ambiantSounds[index])
                                        .foregroundColor(Color.init("TextColor"))
                                    Spacer()
                                    if selectedAmbiantSound == ambiantSounds[index] {
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
                settingsViewModel.getAmbiantSound()
                selectedAmbiantSound = settingsViewModel.selectedAmbiantSound
            })
            .onDisappear(perform: {
                settingsViewModel.getAmbiantSound()
            })
        }
        
    }
}

struct SettingsPickerAmbiantView_Previews: PreviewProvider {
    @State static var selectedSound: String = ""
    @State static var showPicker: Bool = false
    
    static var previews: some View {
        SettingsPickerAmbiantView(selectedAmbiantSound: $selectedSound, showPicker: $showPicker)
    }
}
