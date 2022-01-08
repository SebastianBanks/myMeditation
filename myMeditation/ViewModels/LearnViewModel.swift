//
//  LearnViewModel.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/6/21.
//

import Foundation

class LearnViewModel {
    
    var data = [
        ListData(Image: "lotusImage", title: "What is Meditation", date: "12 Aug", postType: ["How to", "Meditation", "Mindfulness"], tag: .whatIsMeditation),
        ListData(Image: "meditateImage", title: "Types of Meditation", date: "15 dec", postType: ["Buddhism", "Meditation", "Mindfulness"], tag: .typesOfMeditation),
        ListData(Image: "bellsImage", title: "Why Meditate", date: "20 Nov", postType: ["Benefits", "Meditation", "Mental Health"], tag: .whyMeditate)
        ]
    
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
}
