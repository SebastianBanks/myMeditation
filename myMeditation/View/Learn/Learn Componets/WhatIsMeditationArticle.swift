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
        
        ArticleViewLayout(articleName: "What is Meditation", articleText: vm.getArticleText(fileName: "What is Meditation", fileType: "txt"), image: "articleLotusImage")
    }
}

struct HowToMeditateArticle_Previews: PreviewProvider {
    static var previews: some View {
        WhatIsMeditationArticle()
    }
}
