//
//  TypesOfMeditationArticle.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/16/21.
//

import SwiftUI

struct TypesOfMeditationArticle: View {
    
    func getArticleText(fileName: String, fileType: String) -> String {
        var fileText = ""
        if let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let contents = try String(contentsOfFile: filepath)
                fileText = contents
            } catch {
                print("contents could not be loaded")
            }
        }else {
            print("example.txt not found!")
        }
        return fileText
    }
    
    var body: some View {
        
        ArticleViewLayout(articleName: "Types of Meditation", articleText: getArticleText(fileName: "Types of Meditation", fileType: "txt"), image: "articleMeditationImage")
    }
}

struct TypesOfMeditationArticle_Previews: PreviewProvider {
    static var previews: some View {
        TypesOfMeditationArticle()
    }
}
