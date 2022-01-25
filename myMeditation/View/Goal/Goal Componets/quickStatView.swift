//
//  quickStatView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/15/21.
//

import SwiftUI

struct quickStatView: View {
    
    var goalsViewModel = GoalsViewModel()
    @Binding var streak: Int
    @Binding var meditatedToday: Int
    @Binding var meditatedWeek: Double
    
    var body: some View {
        HStack {
            VStack {
                Text("🔥 \(streak)")
                    .padding(.bottom, 5)
                    .font(.system(size: 20))
                Text("Streak")
                    .font(.system(size: 15))
                
            }
            .offset(y: -9)
            .padding()
            
            
            Text("|")
                .bold()
                .font(.system(size: 40))
                .offset(y: -3)
            VStack {
                Text("\(meditatedToday) mins")
                    .padding(.bottom, 5)
                    .font(.system(size: 20))
                Text("Meditated Today")
                    .font(.system(size: 15))
            }
            .padding()
            
            Text("|")
                .bold()
                .font(.system(size: 40))
                .offset(y: -3)
            VStack {
                Text("\(goalsViewModel.timeToString(timeRemaining: meditatedWeek))")
                    .padding(.bottom, 5)
                    .font(.system(size: 20))
                Text("Meditated This Week")
                    .font(.system(size: 15))
            }
            .padding()
            
        }
        .foregroundColor(Color.init("TextColor"))
        .font(.system(size: 25))
        .padding()
        
    }
}

/*
struct quickStatView_Previews: PreviewProvider {
    static var previews: some View {
        quickStatView(streak: 2, meditatedToday: 10, meditatedWeek: 20)
    }
}
*/
