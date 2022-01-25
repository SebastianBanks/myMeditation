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
    @State var selectedCompletionSound = ""
    @State var showCompletionPicker = false
    @State var selectedAmbiantSound = ""
    @State var showAmbiantPicker = false
    @State var alertType: myAlerts? = nil
    @State var showAlert = false
    @State var buddhaModeAlert = false
    @State var healthImage: Image = Image(systemName: "heart")
    
    enum myAlerts {
        case authorized
        case denied
        case buddhaAlert
    }
    
    
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("General")) {
                    
                    notificationToggle(notificationManager: notificationManager, title: "Notifications", imgName: "app.badge", key: notificationKeys.notificationsOn)
                    
                    reminderNotificationToggle(notificationManager: notificationManager, title: "Meditation Reminder", imgName: "app.badge", key: notificationKeys.meditationReminderOn)
                    
                    motivationNotificationToggle(notificationManager: notificationManager, title: "Mindful Motivation", imgName: "app.badge", key: notificationKeys.mindfulMotivationOn)
                    
                    SettingsToggleCell(title: "Buddha Mode", imgName: "clock", key: "buddhaMode")
                    
                            
                    
                    
                    Button(action: {
                        let delaytime = DispatchTime.now() + 7.0
                        if settingsViewModel.healthStore?.status == .notDetermined {
                            settingsViewModel.requestAuthorization()
                            DispatchQueue.main.asyncAfter(deadline: delaytime, execute: {
                                settingsViewModel.updateStatusImage()
                                healthImage = settingsViewModel.statusImage
                            })
                        } else {
                            switch settingsViewModel.healthStore?.status {
                            case .sharingDenied:
                                self.alertType = .denied
                            case .sharingAuthorized:
                                self.alertType = .authorized
                            default:
                                self.alertType = nil
                            }
                            
                            showAlert.toggle()
                            
                            print("\(showAlert)")
                        }
                    }) {
                        HealthButton(title: "Apple Health", imgName: "heart", settingsViewModel: settingsViewModel, image: $healthImage)
                    }
                    .alert(isPresented: $showAlert, content: {
                        returnAlert()
                    })
                    

                }
                
                Section(header: Text("Sound & Haptics")) {
                    SettingsToggleCell(title: "Vibration", imgName: "speaker", key: VibrationKey.vibrationOn)
                    
                    SettingsToggleCell(title: "Completion Sound", imgName: "speaker", key: SoundKey.soundOn)
                    
                    SettingsToggleCell(title: "Ambiant Sound", imgName: "speaker", key: AmbiantKey.ambiantOn)
                    
                    Button(action: {
                        showCompletionPicker = true
                    }) {
                        SettingsCompletionPickerCell(title: "Completion Sound", imgName: "speaker", pickerName: "", selectedSound: $selectedCompletionSound)
                    }
                    
                    Button(action: {
                        showAmbiantPicker = true
                    }) {
                        SettingsAmbiantPickerCell(title: "Ambiant Sound", imgName: "speaker", pickerName: "", selectedSound: $selectedAmbiantSound)
                    }
                }

                Section(header: Text("Support")) {
                    
                    Button(action: {
                        self.isShowingMessages = true
                    }) {
                        SettingsCell(title: "Invite Friends", imgName: "person.3")
                    }
                    .sheet(isPresented: self.$isShowingMessages) {
                                MessageComposeView(recipients: [], body: "https://apps.apple.com/us/app/mymeditation-mindfulness-app/id1601051456") { messageSent in
                                    print("MessageComposeView with message sent? \(messageSent)")
                                }.ignoresSafeArea(.keyboard)
                            }
                    
                    /*
                    SettingsCell(title: "Tip Jar", imgName: "dollarsign.circle")
                    */
                    Button(action: {
                        if let url = URL(string: "itms-apps://apple.com/app/id1601051456") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsCell(title: "Rate myMeditation", imgName: "star")
                    }
                    
                }
                
                

            }.navigationBarTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(settingsViewModel)
        .environmentObject(notificationManager)
        .onAppear(perform: {
            settingsViewModel.soundManager.updateCompletionSound()
            settingsViewModel.soundManager.updateAmbiantSound()
            settingsViewModel.getCompletionSound()
            settingsViewModel.getAmbiantSound()
            selectedCompletionSound = settingsViewModel.selectedCompletionSound
            selectedAmbiantSound = settingsViewModel.selectedAmbiantSound
            self.healthImage = settingsViewModel.statusImage
            
            switch settingsViewModel.healthStore?.status {
            case .sharingAuthorized:
                self.alertType = .authorized
            case .sharingDenied:
                self.alertType = .denied
            default:
                self.alertType = nil
            }
            
        })
        .onAppear(perform: notificationManager.updateToggles)
        .onChange(of: notificationManager.notificationsOn) { toggle in
            notificationManager.updateToggles()
        }
        .onChange(of: settingsViewModel.buddhaModeOn, perform: { bool in
            if settingsViewModel.buddhaModeOn == true {
                alertType = .buddhaAlert
                showAlert.toggle()
            }
        })
        .onChange(of: settingsViewModel.soundManager.ambiantOn) { bool in
            settingsViewModel.soundManager.ambiantOn = bool
        }
        .fullScreenCover(isPresented: $showCompletionPicker) {
            SoundPickerView(selectedSound: $selectedCompletionSound, showPicker: $showCompletionPicker)
        }
        .fullScreenCover(isPresented: $showAmbiantPicker) {
            SettingsPickerAmbiantView(selectedAmbiantSound: $selectedAmbiantSound, showPicker: $showAmbiantPicker)
        }
    }
    
    func returnBuddaAlert() -> Alert {
        return Alert(
            title: Text("Buddha Mode On"),
            message: Text("You know have the option to meditate hours on end 😄"), dismissButton: .cancel())
    }
    
    func returnAlert() -> Alert {
        switch alertType {
        case .authorized:
            return Alert(
                title: Text("Health access is authorized"),
                message: Text("You have authorized saving mindful data in the health app. If you wish to change this please go to the Health App > Profile > Apps > myMeditation > Turn Off All"),
                primaryButton: .default(Text("Health App")) {
                    settingsViewModel.openURL(urlString: "x-apple-health://")
                },
                secondaryButton: .cancel()
            )
        case .denied:
            return Alert(
                title: Text("Health access was denied"),
                message: Text("Seems you've denied health access. If you wish to change this please go to the Health App > Profile > Apps > myMeditation > Turn On All"),
                primaryButton: .default(Text("Health App")) {
                    settingsViewModel.openURL(urlString: "x-apple-health://")
                },
                secondaryButton: .cancel()
            )
        case .buddhaAlert:
            return Alert(
                title: Text("Buddha Mode On"),
                message: Text("You now have the option to meditate for hours on end, see the change in the meditation view 😄"),
                dismissButton: .cancel()
            )
        default:
            return Alert(title: Text("Error"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}

