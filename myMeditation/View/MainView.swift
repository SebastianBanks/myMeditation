//
//  MainView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/19/21.
//

import SwiftUI

struct MainView: View {
    
    init() {
        
        UITabBar.appearance().barTintColor = UIColor(named: "TabBarColor")
    }
    
    @State private var selectedView: Tabs = .meditate
    
    private enum Tabs: Hashable {
        case meditate
        case goals
        case learn
        case settings
    }
    
    var body: some View {
        
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.colorScheme, .dark)
    }
}
