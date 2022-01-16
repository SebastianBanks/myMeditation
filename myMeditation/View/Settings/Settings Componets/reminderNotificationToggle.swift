//
//  reminderNotificationToggle.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/15/21.
//

import SwiftUI

struct reminderNotificationToggle: View {
    
    @ObservedObject var notificationManager: NotificationManager
    
    var title: String
    var imgName: String
    var key: String
    
    var body: some View {
        
        HStack {
            
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(Color.init("BarColor"))
            
            Text(title)
                .padding(.leading, 10)
                .foregroundColor(Color.init("TextColor"))
            
            Spacer()
            
            Toggle("", isOn: $notificationManager.meditationReminderOn)
        }
        .onAppear {
            notificationManager.reloadAuthorizationStatus()
        }
        .onAppear(perform: notificationManager.updateToggles)
        .onChange(of: notificationManager.meditationReminderOn) { toggleIsOn in
            
            if notificationManager.meditationReminderOn == false {
                notificationManager.deleteReminderNotification()
                notificationManager.reloadNotifications()
            }
            
            notificationManager.getStatusSetToggle(isOn: toggleIsOn, key: key)
            notificationManager.updateToggles()
        }
    }
}

