//
//  motivationNotificationToggle.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/15/21.
//

import SwiftUI

struct motivationNotificationToggle: View {
    
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
            
            Toggle("", isOn: $notificationManager.mindfulMotivationOn)
        }
        .onAppear {
            notificationManager.reloadAuthorizationStatus()
        }
        .onAppear(perform: notificationManager.updateToggles)
        .onChange(of: notificationManager.mindfulMotivationOn) { toggleIsOn in
            
            if notificationManager.mindfulMotivationOn == false {
                notificationManager.deleteMindfulMotivationNotifications()
                notificationManager.reloadNotifications()
            }
            
            notificationManager.getStatusSetToggle(isOn: toggleIsOn, key: key)
            notificationManager.updateToggles()
            
            
            if notificationManager.mindfulMotivationOn == true {
                for notification in notificationManager.notifications {
                    print(notification.content.body)
                    print(notification.trigger ?? "error")
                }
            }
             
        }
    }
}
