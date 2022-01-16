//
//  MainView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/19/21.
//

import SwiftUI



@available(iOS 15, *)
struct AppMainView: View {
    
    @ObservedObject var notificationManager = NotificationManager()
    @ObservedObject var goalsViewModel = GoalsViewModel()
    @ObservedObject var settingsViewModel = SettingsViewModel()

    
    init() {
        
        UITabBar.appearance().barTintColor = UIColor(named: "TabBarColor")
    }
    
    @State private var selectedView: Tabs = .meditate
    @AppStorage("onboard", store: .standard) var showOnboard: Bool = true
    
    private enum Tabs: Hashable {
        case meditate
        case goals
        case learn
        case settings
    }
    
    var body: some View {
        
        if showOnboard {
            OnboardingView()
                .accentColor((Color.init("ButtonColor")))
                .environmentObject(goalsViewModel)
                .environmentObject(settingsViewModel)
                .environmentObject(notificationManager)
                .onAppear {
                    goalsViewModel.updateViewData()
                }
        } else {
            TabView(selection: $selectedView) {
                MeditationView()
                    .tabItem {
                        Image(systemName: "helm")

                        Text("Meditate")
                    }.tag(Tabs.meditate)
                GoalView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Goals")
                    }.tag(Tabs.goals)
                LearnView()
                    .tabItem {
                        Image(systemName: "graduationcap")
                        Text("Learn")
                    }.tag(Tabs.learn)
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }.tag(Tabs.settings)
                    
            }
            .accentColor((Color.init("ButtonColor")))
            .edgesIgnoringSafeArea(.top)

        }
        
    }
}

@available(iOS 15, *)
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView()
//          .environment(\.colorScheme, .dark)
    }
}
