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
        
        ArticleViewLayout(articleName: "Why Meditate", articleText: vm.getArticleText(fileName: "Why Meditate", fileType: "txt"), image: "articleBellsImage")
    }
}

struct WhyMeditateArticle_Previews: PreviewProvider {
    static var previews: some View {
        WhyMeditateArticle()
    }
}
