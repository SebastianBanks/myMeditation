//
//  ContentView.swift
//  Shared
//
//  Created by Sebastian Banks on 10/1/21.
//

import SwiftUI
import HealthKit

struct SettingsView: View {
    
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @StateObject var notificationManager = NotificationManager()
    
    
    @State private var isShowingMessages = false
    @State var selectedSound = ""
    @State var showPicker = false
    
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("General")) {
                    
                    notificationToggle(notificationManager: notificationManager, title: "Notifications", imgName: "app.badge", key: notificationKeys.notificationsOn)
                    
                    reminderNotificationToggle(notificationManager: notificationManager, title: "Meditation Reminder", imgName: "app.badge", key: notificationKeys.meditationReminderOn)
                    
                    motivationNotificationToggle(notificationManager: notificationManager, title: "Mindful Motivation", imgName: "app.badge", key: notificationKeys.mindfulMotivationOn)
                    
                    SettingsToggleCell(title: "Sound", imgName: "speaker", key: SoundKey.soundOn)
                    
                    SettingsToggleCell(title: "Vibration", imgName: "speaker", key: VibrationKey.vibrationOn)
                    
                            
                    Button(action: {
                        showPicker = true
                    }) {
                        SettingsPickerCell(title: "Completion Sound", imgName: "speaker", pickerName: "", selectedSound: $selectedSound)
                    }
                    
                    HealthButton(title: "Apple Health", imgName: "heart", settingsViewModel: settingsViewModel)
                    
                    

                }
                /*
                Section(header: Text("Support")) {
                    
                    Button(action: {
                        self.isShowingMessages = true
                    }) {
                        SettingsCell(title: "Invite Friends", imgName: "person.3")
                    }
                    .sheet(isPresented: self.$isShowingMessages) {
                                MessageComposeView(recipients: ["recipients"], body: "Message goes here") { messageSent in
                                    print("MessageComposeView with message sent? \(messageSent)")
                                }.ignoresSafeArea(.keyboard)
                            }
                    
                    /*
                    SettingsCell(title: "Tip Jar", imgName: "dollarsign.circle")
                    */
                    Button(action: {
                        if let url = URL(string: "itms-apps://apple.com/app/id1477376905") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsCell(title: "Rate myMeditation", imgName: "star")
                    }
                    
                }
                */
                

            }.navigationBarTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(settingsViewModel)
        .environmentObject(notificationManager)
        .onAppear(perform: {
            settingsViewModel.soundManager.updateCompletionSound()
            settingsViewModel.getSelectedSound()
            selectedSound = settingsViewModel.selectedSound
        })
        .onAppear(perform: notificationManager.updateToggles)
        .onChange(of: notificationManager.notificationsOn) { toggle in
            notificationManager.updateToggles()
        }
        /*
        .onChange(of: showPicker) { value in
            if showPicker == true {
                SoundPickerView(selectedSound: $selectedSound)
            }
        
        }
         */
        .fullScreenCover(isPresented: $showPicker) {
            SoundPickerView(selectedSound: $selectedSound, showPicker: $showPicker)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

