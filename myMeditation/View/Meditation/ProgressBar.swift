//
//  ProgressBar.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/7/21.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Float
    var text: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.init("ProgressBar"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(text)
                .font(.system(size: 50))
                .bold()
                .foregroundColor(Color.init("TextColor"))
        }
    }
}
