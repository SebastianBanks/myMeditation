//
//  BarChartCell.swift
//  CoreDataPractice
//
//  Created by Sebastian Banks on 9/24/21.
//

import Foundation
import SwiftUI

struct BarChartCell: View {
    
    var value: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.init("BarColor"))
            .scaleEffect(CGSize(width: 1, height: value), anchor: .bottom)
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        BarChartCell(value: 800)
            .previewLayout(.sizeThatFits)
    }
}
