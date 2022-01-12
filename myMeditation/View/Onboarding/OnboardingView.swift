//
//  OnboardingView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 12/31/21.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var notificationManager = NotificationManager()
    @ObservedObject var goalsViewModel = GoalsViewModel()
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @State var date: Date = Date()
    
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    @AppStorage("onboard", store: .standard) var showOnboard: Bool = true
    
    
    var body: some View {
        
        ZStack {
            switch onboardingState {
            case 0:
                page1
                    .transition(transition)
            case 1:
                page2
                    .transition(transition)
            case 2:
                page3
                    .transition(transition)
            default:
                MeditationView()
                
            }
        }
        .environmentObject(goalsViewModel)
        .environmentObject(settingsViewModel)
        .environmentObject(notificationManager)
        .onAppear {
            goalsViewModel.updateViewData()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

extension OnboardingView {
    
    private var page1: some View {
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
        
            NavigationView {
                VStack {
                        Text("I wanted to take the time and thank you for downloading myMeditation. This is my first app so I really appreciate it. I have a lot planned for the future of myMeditation, so stay tuned! If you have any suggestions or concerns please leave them in the app review. Again thank you so much. Happy Meditating 😄🙏")
                            .font(.system(size: 20))
                            .padding(.top, 20)
                            .padding()
                        
                        Text("Your Developer,")
                            .padding(.leading, -175)
                            .padding(1)
                        Text("Sebastian B.")
                            .padding(.leading, -150)
                    
                        Spacer()
                            .frame(minHeight: 65, idealHeight: 170, maxHeight: .infinity)
                    
                        bottomButton
                            .frame(width: 150, height: 90, alignment: .center)
                            .padding()
                            .padding(.top, 50)
                    }
                .navigationTitle("Thank You 😄🙏")
            }
        }
    }
    
    private var page3: some View {
        NavigationView {
            ZStack {
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)

                VStack  {
                    
                    ZStack {
                        Text("Select the days you'd like to meditate:")
                            .padding()
                            .padding(.top, 20)
                            .font(.title2)
                    }
                    .zIndex(1)
                    
                    
                    EditGoalWidgetView()
                        .offset(y: -250)
                        
                    if notificationManager.meditationReminderOn == true {
                        DatePicker("Reminder Time:", selection: $date, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.automatic)
                            .font(.title2)
                            .padding()
                            .offset(y: -200)
                    }
                    
                    bottomButton
                        .padding()
                        .frame(width: 300, height: 70, alignment: .center)
                    
                }
                .navigationTitle("Edit Goal:")
                .environmentObject(goalsViewModel)
                .onAppear {
                    goalsViewModel.updateViewData()
                }
            }
        }
    }
    
    private var page2: some View {
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            
            VStack {
                
                SettingsView()
                
                bottomButton
                    .frame(width: 150, height: 90, alignment: .center)
                    .offset(y: 25)
                    .padding()
                    .padding(.top, 50)
                }
            }
        .environmentObject(settingsViewModel)
        .environmentObject(notificationManager)
        
    }
    
    private var bottomButton: some View {
        Button(action: {
            
            if onboardingState == 2 && notificationManager.meditationReminderOn == true {
                print("notification")
                goalsViewModel.createNotifications(date: date)
                goalsViewModel.notificationManager.reloadNotifications()
                for notifications in goalsViewModel.notificationManager.notifications {
                    print("\(notifications.content.title)")
                }
            }
            
            handleNextButtonPressed()
        }) {
            EditGoalButtonView(buttonText: onboardingState == 2 ? "Finish" : "Next")
        }
    }
}

extension OnboardingView {
    
    func turnOffOnboard() {
        showOnboard = false
    }
    
    func handleNextButtonPressed() {
        
        if onboardingState == 2 {
            turnOffOnboard()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
}
