//
//  DonateView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/19/21.
//

import SwiftUI



struct SettingsView: View {
    
    @State var notificationsOn = true
    @State var meditationRemindersOn = true
    @State var mindfulMotivationOn = true
    
    @State var soundOn = true
    @State var vibrationOn = true
    var soundChoices = ["no sound", "some sound", "alotta sound"]
    @State var soundChoice = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("General")) {
                    
                    SettingsToggleCell(title: "Notifications", imgName: "app.badge", toggle: $notificationsOn)
                    
                    SettingsToggleCell(title: "Meditation Reminders", imgName: "app.badge", toggle: $meditationRemindersOn)
                    
                    SettingsToggleCell(title: "Mindful Motivation", imgName: "app.badge", toggle: $mindfulMotivationOn)
                    
                    SettingsToggleCell(title: "Sound", imgName: "speaker", toggle: $soundOn)
                    
                    SettingsToggleCell(title: "Vibration", imgName: "speaker", toggle: $vibrationOn)
                            
                    SettingsPickerCell(title: "Completion Sound", imgName: "speaker", pickerName: "", items: soundChoices, selected: $soundChoice)
                    
                    SettingsCell(title: "Apple Health", imgName: "heart")
                            
                    }

                
                Section(header: Text("Support")) {

                    SettingsCell(title: "Invite Friends", imgName: "person.3")
    
                    SettingsCell(title: "Tip Jar", imgName: "dollarsign.circle")
                            
                    SettingsCell(title: "Rate myMeditation", imgName: "star")
                            
                    
                }
                
                

            }.navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
