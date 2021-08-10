//
//  MyMeditationApp.swift
//  MyMeditation WatchKit Extension
//
//  Created by Sebastian Banks on 7/3/21.
//

import SwiftUI

@main
struct myMeditationApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
