//
//  myMeditationApp.swift
//  myMeditationWatch WatchKit Extension
//
//  Created by Sebastian Banks on 12/18/21.
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
