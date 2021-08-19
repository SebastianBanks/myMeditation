//
//  ArticleViewLayout.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/16/21.
//

import SwiftUI

struct ArticleViewLayout: View {
    
    var articleName: String
    var articleText: String
    var image: String
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
                StickyHeader {
                    StickyHeader {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
            
            ZStack {
                Color.init("BackgroundColor")
                VStack {
                    Text(articleName)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()
                        
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.init("TextColor"))
                        
                    
                    Text(articleText)
                        .padding(.top, -20)
                        .padding(40)
                        .font(.system(size: 25))
                        
                        
                    
                }
            }.cornerRadius(25)
            .offset(y: -100)
            
            

                
            
                    
                                

            }
        
                
    }
}

struct ArticleViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        ArticleViewLayout(articleName: "Why Meditate", articleText: "Lorem ipsum", image: "articleLotusImage")
    }
}
