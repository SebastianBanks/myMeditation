//
//  GoalWidgetView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/20/21.
//

import SwiftUI

struct GoalWidgetView: View {
    
    var title: String
    var bodyText: String
    
    var body: some View {
        VStack {
            VStack {
                Text("\(title):")
                    
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(bodyText)")
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.bottom, 5)
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .frame(width: 350, height: 130)
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
        
    }
}


struct GoalWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        GoalWidgetView(title: "Title", bodyText: "body")
    }
}
