//
//  LearnView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct LearnView: View {
    
    var learnViewModel = LearnViewModel()
    
    var body: some View {
        
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            LearnTopicCell(d: learnViewModel.data)
            
            
            
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
