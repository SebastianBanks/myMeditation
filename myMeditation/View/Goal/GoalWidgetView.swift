//
//  GoalWidgetView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/20/21.
//

import SwiftUI

struct GoalWidgetView: View {
    
    var buttonText: String
    
    var body: some View {
        VStack {
        Text(buttonText)
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
                            LinearGradient(gradient: Gradient(colors: [Color.init("BackgroundColor"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
        
    }
}


struct GoalWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        GoalWidgetView(buttonText: "hello world")
    }
}
