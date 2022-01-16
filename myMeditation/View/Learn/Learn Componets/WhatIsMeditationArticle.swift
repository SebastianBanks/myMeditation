//
//  HowToMeditateArticle.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/16/21.
//

import SwiftUI

struct WhatIsMeditationArticle: View {
    
    var vm = LearnViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
                StickyHeader {
                    StickyHeader {
                        Image("articleLotusImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
            
            ZStack {
                Color.init("BackgroundColor").ignoresSafeArea(.all)
                VStack {
                    Text("What is Meditation")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.init("TextColor"))
                    
                    Group {
                        Text("Meditation can be a life-changing habit that makes you a better individual and builds skills that you will utilize every day. Many people get the wrong idea of what meditation is. Many believe that meditation isn’t for them because their minds are just too busy. In actuality, that is what makes meditation perfect. Everyone can benefit from meditating. It will not only have an influence on you but the people around you.")
                        
                        Text("So, what is meditation? Isn’t the goal to empty your mind of thoughts? Although you might experience this after some practice, emptying the mind of all thoughts isn’t the point of meditation. Meditation is the practice of focusing your attention. Meaning you're not expected to acquire a completely blank mind during meditation. You’ll have thoughts and interruptions that you’ll gently push away by bringing your attention back to your breath or whatever you're meditating on. As you practice this over time, you’ll have an increased ability to focus on a single thought and live your life more in the present moment. ")
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.system(size: 23))
 
                    
                }
            }.cornerRadius(25)
            .offset(y: -50)

            }
        
                
    }
}

struct HowToMeditateArticle_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsMeditationArticle()
    }
}


//, articleText: vm.getArticleText(fileName: "What is Meditation", fileType: "txt")
