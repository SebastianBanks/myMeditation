//
//  StopWatchView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 1/29/22.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject var meditationViewModel = MeditationViewModel()
    @Binding var timeReamaining: Double
    
    var body: some View {
        Text(meditationViewModel.timeToString(timeRemaining: timeReamaining))
            .font(.system(size: 50))
            .bold()
            .foregroundColor(Color.init("TextColor"))
            .padding()
            
        
    }
}

struct StopWatchView_Previews: PreviewProvider {
    @State static var timeRemaining = 120.0
    
    static var previews: some View {
        StopWatchView(timeReamaining: $timeRemaining)
    }
}
