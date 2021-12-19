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
        
        ArticleViewLayout(articleName: "Types of Meditation", articleText: vm.getArticleText(fileName: "Types of Meditation", fileType: "txt"), image: "articleMeditationImage")
    }
}

struct TypesOfMeditationArticle_Previews: PreviewProvider {
    static var previews: some View {
        TypesOfMeditationArticle()
    }
}
