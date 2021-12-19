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
            ZStack{
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)

                VStack  {
                    EditGoalWidgetView()
                        .offset(y: -300)
                        
                    if nm.meditationReminderOn == true {
                        DatePicker("Reminder Time:", selection: $date, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.automatic)
                            .font(.title2)
                            .padding()
                            .offset(y: -350)
                    }
                    
                    
                    Button(action: {
                        
                        vm.createNotifications(date: date)
                        self.showSheet = false
                        
                    }) {
                        EditGoalButtonView()
                    }
                    .padding()
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
