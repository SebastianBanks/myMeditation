//
//  CurrentGoalWidget.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/16/21.
//

import SwiftUI

struct CurrentGoalWidget: View {
    
    @StateObject var vm = GoalsViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Current Goal:")
                    
                    .padding(.bottom, 10)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    dayGoalCircle(day: "S", color: vm.sunGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "M", color: vm.monGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "T", color: vm.tuesGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "W", color: vm.wedGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "T", color: vm.thurGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "F", color: vm.friGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    dayGoalCircle(day: "S", color: vm.satGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                    
                }
                .font(.title2)
                .padding()
                .offset(y: -15)
            }
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .frame(width: 350, height: 150)
            .foregroundColor(Color.init("TextColor"))
            .background(
                ZStack {
                    Color.init("BackgroundColor")
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundColor(.clear)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.init("BackgroundColor"), Color.init("WidgetColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            .shadow(color: Color("DarkShadow"), radius: 20, x: 20, y: 20)
            .shadow(color: Color("LightShadow"), radius: 20, x: -20, y: -20)
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(vm)
    }
    
}

struct CurrentGoalWidget_Previews: PreviewProvider {
    

    
    static var previews: some View {
        CurrentGoalWidget()
    }
}
