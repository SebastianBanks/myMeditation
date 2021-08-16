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
    
    var body: some View {
        ZStack {
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            
            NavigationView {
                ScrollView {
                    Text(articleText)
                        .padding(40)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.leading)
                        .navigationTitle(articleName)
                }
            }
        }
    }
}

struct ArticleViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        ArticleViewLayout(articleName: "Why Meditate", articleText: "Lorem ipsum")
    }
}
