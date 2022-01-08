//
//  ListData.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/12/21.
//

import Foundation

struct ListData: Identifiable,Hashable {
    var id = UUID()
    var Image: String
    var title: String
    var date: String
    var postType: Array<String>
    var tag: ArticleView.Article
}



