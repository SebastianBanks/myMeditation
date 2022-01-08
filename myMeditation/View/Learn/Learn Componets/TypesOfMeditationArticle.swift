//
//  TypesOfMeditationArticle.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/16/21.
//

import SwiftUI

struct TypesOfMeditationArticle: View {
    
    var vm = LearnViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
                StickyHeader {
                    StickyHeader {
                        Image("articleMeditationImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
            
            ZStack {
                Color.init("BackgroundColor").ignoresSafeArea(.all)
                VStack {
                    Text("Types of Meditation")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.init("TextColor"))
                    
                    Group {
                        Text("When people think about meditation, most imagine sitting on the ground in silence focusing on the breath. However there are hundreds of ways to meditate. If you’ve tried meditation and didn’t like it perhaps there’s another form of meditation that’s more suited for you. Here are a few popular meditations you can try.")
                    
                        Text("Concentration:")
                            .bold()
                            .font(.system(size: 30))
                                      
                        Text("Concentration meditation is what usually comes to mind when people think about meditation. This is because it’s easily one of the most popular forms of meditation, and, because it directly applies what all meditations aim to do. To practice concentration meditation you aim your attention on one thing. This could be your breath, a candle flame, a sound, or even a feeling. As you focus on this one thing you’ll have many thoughts that take hold of your attention. You simply let them go and bring your focus back to whatever you're meditating on.")
                    
                        Text("Walking Meditation:")
                            .bold()
                            .font(.system(size: 30))
                                      
                        Text("If you're someone who doesn’t like the idea of sitting in one place then walking meditation may be perfect for you. To practice walking meditation you want to be mindful of each step that goes into a step. That is lifting one foot off the ground, moving that foot ahead of you, placing that foot on the ground, and the shifting of your weight as you move forward. You’ll repeat this process with each step you take. As your mind wanders, gently bring your attention back to the process of each step.")
                             
                        Text("It should be noted that you don’t just have to direct your focus towards your steps. You can also direct it towards your breath, the scenery you pass by, and the sounds you hear around you. The most important thing is focusing your attention on one thing and bringing it back when your mind wanders.")
                                      
                        Text("Contemplation:")
                                .bold()
                                .font(.system(size: 30))
                    
                        Text("You may be wondering how contemplation can be a form of meditation. Remember the point of meditation is not to empty your mind but to practice focus. Contemplation does just this. When contemplating you want to focus whatever you're thinking about on a single subject. Like all forms of meditation, this is great to do in nature. Taking in the world around you and taking it in, in all its beauty.")
                                      
                    Text("Mindfulness:")
                        .bold()
                        .font(.system(size: 30))

                    Text("You’ve probably heard a great deal about mindfulness, but what is mindfulness? Mindfulness is the observation of one’s thoughts, feelings, and sensations without passing judgment. To practice mindfulness. Start with taking a couple of deep breaths in through the nose and out through the mouth. Pay attention to how it feels, then continue by shifting your focus on how your body feels. Slowly scan your body in your mind head to toe, being aware of the thoughts, feelings, and sensations as you scan each body part. Remember to not attach yourself or pass judgment to what arises but to simply witness them as if you're a bystander. After you’ve scanned each body part bring your attention back to the breath, this time just breathing normally. Follow the breath in and out and continue to witness how the body feels and anything that may arise. When you notice your focus getting caught up in a thought, bring it back to your breath.")
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.system(size: 23))
                    
                Text("Here’s a passage by Suzuki Roshi in Zen Mind, Beginner Mind. “When you are practicing Zazen meditation do not try to stop your thinking. Let it stop by itself. If something comes into your mind, let it come in and let it go out. It will not stay long. When you stop your thinking, it means you are bothered by it. Do not be bothered by anything. It appears that the something comes from outside your mind, but actually it is only the waves of your mind and if you are not bothered by the waves, gradually they will become calmer and calmer…”. I found this passage in Ram Dass’s book Journey of Awakening a meditator’s guidebook.")
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


struct TypesOfMeditationArticle_Previews: PreviewProvider {
    static var previews: some View {
        TypesOfMeditationArticle()
    }
}
