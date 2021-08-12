//
//  LearnView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            VStack {
                Text("Learn")
                    .font(.system(size: 60))
                    .bold()
                    .font(.title)
                    
                    .padding()
                    .frame(width: 390, height: 80, alignment: .leading)
            
            
                VStack(spacing: -45) {
                    LearnTopicCell(topicName: "How to Meditate")
                    LearnTopicCell(topicName: "Types of Meditation")
                    LearnTopicCell(topicName: "Why Meditate")
                }
            }
            
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
