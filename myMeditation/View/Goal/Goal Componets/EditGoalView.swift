//
//  EditGoalView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 12/3/21.
//

import SwiftUI

struct EditGoalView: View {
    
    @ObservedObject var nm = NotificationManager()
    @ObservedObject var vm = GoalsViewModel()
    @Binding var date: Date
    @Binding var showSheet: Bool
    
    var body: some View {
        
        NavigationView {
            ZStack {
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)

                VStack  {
                    ZStack {
                        Text("Select the days you'd like to meditate:")
                            .padding()
                            .padding(.top, 20)
                            .font(.title2)
                            .offset(y: 20)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .zIndex(2)
                    
                    Spacer()
                    
                    ZStack {
                        EditGoalWidgetView()
                            .frame(height: 400, alignment: .center)
                            .offset(y: -240)
                    }
                    .zIndex(1)
                    
                    
                    Spacer()
                        
                    if nm.meditationReminderOn == true {
                        DatePicker("Reminder Time:", selection: $date, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.automatic)
                            .font(.title2)
                            .padding()
                            .frame(height: 30, alignment: .center)
                            .offset(y: -220)
                    }
                    
                        Button(action: {
                            
                            vm.createNotifications(date: date)
                            self.showSheet = false
                            
                        }) {
                            EditGoalButtonView(buttonText: "Save Goal")
                        }
                        .padding()
                        .padding(.bottom)
                        .offset(y: -50)
                        .frame(width: 300, height: 70, alignment: .center)
                    
                }
            }
            .navigationTitle("Edit Goal:")
            .environmentObject(vm)
        }
        
    }
}


struct EditGoalView_Previews: PreviewProvider {
    
    @State static var showSheet = true
    @State static var date = Date()
    
    static var previews: some View {
        EditGoalView(date: $date, showSheet: $showSheet)
    }
}
