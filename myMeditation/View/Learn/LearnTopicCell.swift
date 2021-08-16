//
//  LearnTopicCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/9/21.
//

import SwiftUI

struct LearnTopicCell: View {
    
    @State var d = data
    
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: GroupedListHeader()) {
                    ForEach(d, id: \.self) { m in
                        VStack {
                            NavigationLink(destination: ArticleView(selectedArticleView: m.tag)) {
                                HStack{
                                    Image(m.Image)
                                        .resizable()
                                        .frame(width: 120, height: 90)
                                    VStack(alignment: .leading, spacing: 8) {
                                        tags(tags: m.postType)
                                        Text(m.title)
                                            .bold()
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        Text("Sebastian Banks")
                                            .font(.caption2)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
            .navigationTitle("Learn")
        }
    }
}

struct GroupedListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "tray.full.fill")
            Text("All Posts from myMeditation")
        }
    }
}

struct tags: View {
    var tags: Array<String>
    var body: some View {
        HStack {
        ForEach(tags, id: \.self) { e in
            Text(e)
                .foregroundColor(.black)
                .font(.system(size: 6))
                .padding(4)
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 0.5)
               )
           }
        }
    }
}
