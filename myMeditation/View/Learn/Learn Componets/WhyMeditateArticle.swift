//
//  WhyMeditateArticle.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/16/21.
//

import SwiftUI

struct WhyMeditateArticle: View {
    
    var vm = LearnViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
                StickyHeader {
                    StickyHeader {
                        Image("articleBellsImage")
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
                        Text("The practice of meditation has many benefits, just like how you exercise and diet to keep your body healthy. Meditation can be used to maintain a healthy mind. As you deepen your meditation practice you’ll find yourself less anxious, more attentive, and overall happier. Meditation also has many benefits that directly affect your health. It’s been known to reduce the effects of age on the brain, lower blood pressure, and increase your ability to deal with chronic pain. Meditation is a powerful tool and there are many more reasons to add it to your daily routine. With consistent practice, you too can reap the rewards that meditation can give you.")
                        
                        Text("Meditation can:")
                            .bold()
                            .font(.system(size: 30))
                            .offset(y: -20)
                        
                        List {
                            Text("- Reduce stress and anxiety")
                            Text("- Improve your ability to focus")
                            Text("- Improve sleep")
                            Text("- Develop love and compassion")
                            Text("- Increase confidence")
                            Text("- Reduce stress and anxiety")
                            Text("- Reduce heart disease")
                            Text("- Counter the affects of aging")
                            Text("- Manage depression")
                        }
                        .colorMultiply(Color.init("BackgroundColor")).padding(.top)
                        .listStyle(.plain)
                        .frame(height: 500)
                        .offset(y: -60)
                        
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


struct WhyMeditateArticle_Previews: PreviewProvider {
    static var previews: some View {
        WhyMeditateArticle()
    }
}
