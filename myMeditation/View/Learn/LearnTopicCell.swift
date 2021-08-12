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
            
            VStack {
            Text(topicName)
                .font(.system(size: 33, weight: .semibold, design: .rounded))
                .frame(width: 350, height: 150)
                .foregroundColor(.white)
                .background(
                    ZStack {
                        Color.init("ButtonColor")
                        
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                            .foregroundColor(.clear)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.init("ButtonColor"), Color(#colorLiteral(red: 0.9528151155, green: 0, blue: 0.1790324748, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                
                .shadow(color: Color("DarkShadow"), radius: 20, x: 20, y: 20)
                .shadow(color: Color("LightShadow"), radius: 20, x: -20, y: -20)
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(10)
            
        }
            
    }
}

