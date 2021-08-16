//
//  ArticleView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct ArticleView: View {
    
    @State var selectedArticleView: Article
    
    enum Article: Hashable {
        case howToMeditate
        case typesOfMeditation
        case whyMeditate
    }
    
    
    
    var body: some View {
        
        if selectedArticleView == Article.howToMeditate {
            HowToMeditateArticle()
        } else if selectedArticleView == Article.typesOfMeditation {
            TypesOfMeditationArticle()
        } else {
            WhyMeditateArticle()
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(selectedArticleView: .howToMeditate)
    }
}
