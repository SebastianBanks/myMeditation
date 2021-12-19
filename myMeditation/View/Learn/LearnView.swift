//
//  LearnView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
           LearnTopicCell()
            
            
            
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
