//
//  BarChart.swift
//  CoreDataPractice
//
//  Created by Sebastian Banks on 9/24/21.
//

import Foundation
import SwiftUI

struct BarChart: View {
    
    var data: [ChartData]
    
    func normalizedValue(index: Int) -> Double {
        var allValues: [Double] {
            var values = [Double]()
            for data in data {
                values.append(data.value)
            }
            return values
        }
        guard let max = allValues.max() else {
            return 1
        }
        if max != 0 {
            return Double(data[index].value)/Double(max)
        } else {
            return 1
        }
        
    }
    
    func timeToString(time: Double) -> String {
        var timeRemainingString: String = ""
        let hours = time/3600
        let minsMinusHours = hours.truncatingRemainder(dividingBy: 1)
        let mins = minsMinusHours * 60
        
        let wholehrs = Int(hours)
        let wholemins = Int(mins)
        
        if wholehrs > 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hrs"
        } else if wholehrs == 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hr"
        } else if wholehrs > 1 && wholemins >= 1 {
            timeRemainingString = "\(wholehrs) hrs \(wholemins) mins"
        } else if wholehrs == 0 && wholemins > 1{
            timeRemainingString = "\(wholemins) mins"
        } else {
            timeRemainingString = "\(wholemins) min"
        }
        
        
        return timeRemainingString
    }
    
    var body: some View {
        if data != [] {
            VStack(alignment: .leading) {
                
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            ForEach(0..<data.count, id: \.self) { i in
                                VStack {
                                    Text(timeToString(time:data[i].value))
                                    BarChartCell(value: normalizedValue(index: i))
                                    Text("\(data[i].label)")
                                    
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        } else {
            Text("No Data yet 😁")
                .bold()
                .font(.title3)
        }
        
    }
}



struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(data: [])
    }
}
 
