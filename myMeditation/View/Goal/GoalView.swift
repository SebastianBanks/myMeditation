//
//  GoalView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct GoalView: View {
    
    @ObservedObject var goalsViewModel = GoalsViewModel()
    @State var editGoal = false
    @State var date = Date()
    
    var body: some View {
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            NavigationView{
                ScrollView{
                    VStack(spacing: 30) {
                        
                        GoalChartView(data: $goalsViewModel.currentWeekData)
                          .padding(.top, 30)
                        
                        quickStatView(streak: $goalsViewModel.streak, meditatedToday: $goalsViewModel.meditatedToday, meditatedWeek: $goalsViewModel.meditatedWeek)
                        
                        CurrentGoalWidget()
                        
                        GoalWidgetView(title: "Total Meditated 🧘", bodyText: "\(goalsViewModel.meditatedTotal) mins")
                        
                        GoalWidgetView(title: "Total Sessions ⏱", bodyText: "\(goalsViewModel.meditationSessions)")
                        
                        GoalWidgetView(title: "Longest Session 🏃", bodyText: "\(goalsViewModel.longestSession) mins")
                        
                        GoalWidgetView(title: "Best Streak 😎", bodyText: "🔥 \(goalsViewModel.bestStreak)")
                        
                    }
                }.navigationTitle("Goals")
                    .navigationBarItems(trailing: Button(action: {
                        editGoal = true
                    }) {
                        Text("Edit Goals")
                            .foregroundColor(Color.init("ButtonColor"))
                            .bold()
                    })
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .environmentObject(goalsViewModel)
        .onChange(of: editGoal, perform: { value in
            if editGoal == false {
//                goalsViewModel.coreData.testData()
                goalsViewModel.updateViewData()
            }
        })
        .onAppear {
            goalsViewModel.updateViewData()
        }
            
        .sheet(isPresented: $editGoal, content: {
            EditGoalView(date: $date, showSheet: $editGoal)
        })
        
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
