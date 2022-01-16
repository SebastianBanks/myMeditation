//
//  EditGoalView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/28/21.
//

import SwiftUI

struct EditGoalWidgetView: View {
    
    @StateObject var vm = GoalsViewModel()
    
    var body: some View {
            
        NavigationView {
            ZStack {
                
                Color.init("BackgroundColor").ignoresSafeArea(.all)

                VStack {

                    HStack {
                        Button(action: {
                            vm.sunGoal.toggle()
                        }) {
                            dayGoalCircle(day: "S", color: vm.sunGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        
                        Button(action: {
                            vm.monGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "M", color: vm.monGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        
                        Button(action: {
                            vm.tuesGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "T", color: vm.tuesGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        Button(action: {
                            vm.wedGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "W", color: vm.wedGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        Button(action: {
                            vm.thurGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "T", color: vm.thurGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        Button(action: {
                            vm.friGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "F", color: vm.friGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                        Button(action: {
                            vm.satGoal.toggle()
                            
                        }) {
                            dayGoalCircle(day: "S", color: vm.satGoal ? Color.init("ProgressBar") : Color.init("ButtonColor"))
                        }
                    }
                    .font(.title2)
                    .padding()
                    
                    
                    
                    
                }
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .frame(width: 350, height: 100)
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
}

struct EditGoalWidgetView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditGoalWidgetView()
    }
}
