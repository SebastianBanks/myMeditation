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

var data = [
    ListData(Image: "lotusImage", title: "How to Meditate", date: "12 Aug", postType: ["How to", "Meditation", "Mindfulness"], tag: .howToMeditate),
    ListData(Image: "meditateImage", title: "Types of Meditation", date: "15 dec", postType: ["Buddhism", "Meditation", "Mindfulness"], tag: .typesOfMeditation),
    ListData(Image: "bellsImage", title: "Why Meditate", date: "20 Nov", postType: ["Benefits", "Meditation", "Mental Health"], tag: .whyMeditate)
    ]

