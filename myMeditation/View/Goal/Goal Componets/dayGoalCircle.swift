//
//  dayGoalCircle.swift
//  myMeditation
//
//  Created by Sebastian Banks on 11/17/21.
//

import SwiftUI

struct dayGoalCircle: View {
    
    var day: String
    var color: Color
    
    var body: some View {
        Text(day)
            .bold()
            .foregroundColor(.white)
            .frame(width: 40, height: 40, alignment: .center)
            .background(color)
            .clipShape(Circle())
    }
}

struct dayGoalCircle_Previews: PreviewProvider {
    static var previews: some View {
        dayGoalCircle(day: "S", color: .gray)
    }
}
