//
//  LearnTopicCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/9/21.
//

import SwiftUI

struct LearnTopicCell: View {
    
    var topicName: String
    
    var body: some View {
        Button(action: { print("goals button") }) {
            Text(topicName)
                .font(.system(size: 45))
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.init("TextColor"))
                .padding()
                .frame(width: 360, height: 150, alignment: .center)
                
                .background(Color.init("ButtonColor"))
                .cornerRadius(40)
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
        }
    }
}

