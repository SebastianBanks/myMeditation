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
    @State var selectedRange = 0
    @State var chartData: [ChartData] = []
    
    var body: some View {
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            NavigationView{
                ScrollView{
                    VStack(spacing: 30) {
                        
                        
                        GoalChartView(data: $chartData, selectedRange: $selectedRange)
                          .padding(.top, 30)
                        
                        quickStatView(streak: $goalsViewModel.streak, meditatedToday: $goalsViewModel.meditatedToday, meditatedWeek: $goalsViewModel.meditatedWeek)
                        
                        CurrentGoalWidget()
                        
                        GoalWidgetView(title: "Total Meditated 🧘", bodyText: "\(goalsViewModel.timeToString(timeRemaining: goalsViewModel.meditatedTotal))")
                        
                        GoalWidgetView(title: "Total Sessions ⏱", bodyText: "\(goalsViewModel.meditationSessions)")
                        
                        GoalWidgetView(title: "Longest Session 🏃", bodyText: "\(goalsViewModel.timeToString(timeRemaining: goalsViewModel.longestSession))")
                        
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
            self.chartData = goalsViewModel.currentWeekData
        }
        .onChange(of: selectedRange) { value in
            print("selectedRange: \(selectedRange)")
            goalsViewModel.updateViewData()
            switch selectedRange {
            case 0:
                self.chartData = goalsViewModel.currentWeekData
            case 1:
                self.chartData = goalsViewModel.currentMonthData
            case 2:
                self.chartData = goalsViewModel.currentYearData
            default:
                self.chartData = goalsViewModel.currentWeekData
            }
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

