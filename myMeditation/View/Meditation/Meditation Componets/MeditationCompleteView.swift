//
//  MeditationCompleteView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/7/21.
//

import SwiftUI

@available(iOS 15, *)
struct MeditationCompleteView: View {
    
    var coreHaptics = CoreHaptics()
    @StateObject var vm = MeditationViewModel()
    @StateObject var gvm = GoalsViewModel()
    
    @Binding var showSheet: Bool
    @Binding var timeMeditated: Double
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)
                ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text(vm.timeToString(timeRemaining: timeMeditated))
                        .font(.largeTitle.bold())
                        .padding()
                        
                
                        Text("🔥 \(gvm.streak)")
                        .padding()
                        .font(.largeTitle.bold())
                        
                        
                    }
                    .frame(width: 380, alignment: .leading)
                    
                    CurrentGoalWidget()
                    
                    GoalWidgetView(title: "Meditated Today 💪", bodyText: "\(gvm.meditatedToday) mins")
                    GoalWidgetView(title: "Total Meditated 🧘", bodyText: "\(gvm.meditatedTotal) mins")
                    
                    
                }
            }
            }
            .onAppear(perform: {
                if vm.soundManager.soundOn == true {
                    vm.soundManager.playCompletionSound()
                }
                if vm.soundManager.vibrationOn == true {
                    coreHaptics?.playHapticsFile(named: "Completion")
                }
                gvm.getStreak()
                gvm.getTotalMeditated()
                gvm.getMeditatedToday()
            })
            .navigationBarItems(leading: Button(action: {
                self.showSheet = false
                vm.resetMeditationValues()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.init("TextColor"))
                        .font(.largeTitle)
                })
            
        }
        
    }
}

@available(iOS 15, *)
struct MeditationCompleteView_Previews: PreviewProvider {
    
    @State static var showSheet = true
    @State static var timeMeditated = 120.0
    
    static var previews: some View {
        MeditationCompleteView(showSheet: $showSheet, timeMeditated: $timeMeditated)
    }
}
