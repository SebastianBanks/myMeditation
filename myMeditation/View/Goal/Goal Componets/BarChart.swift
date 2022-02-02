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
    var goalsViewModel = GoalsViewModel()
    @Binding var selectedRange: Int
    
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
    
    
    var body: some View {
        if data != [] {
            VStack(alignment: .leading) {
                
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            ForEach(0..<data.count, id: \.self) { i in
                                VStack {
                                    Text(goalsViewModel.getChartTimes(timeRemaining:data[i].value))
                                        .font(.system(size: selectedRange == 2 ? 9 : 15))
                                    
                                    
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
    static var weekData1 = [
        ChartData(label: "sun", value: 600.0),
        ChartData(label: "mon", value: 300.0),
        ChartData(label: "tues", value: 4000.0),
        ChartData(label: "wed", value: 750.0),
        ChartData(label: "thur", value: 0.0),
        ChartData(label: "fri", value: 300.0),
        ChartData(label: "sat", value: 600.0),
    ]
    
    static var monthData1 = [
        ChartData(label: "w1", value: 3750.0),
        ChartData(label: "w2", value: 4000.0),
        ChartData(label: "w3", value: 1285.0),
        ChartData(label: "w4", value: 4135.0),
        //ChartData(label: "w5", value: 600.0),
    ]
    
    static var yearData1 = [
        ChartData(label: "j", value: 15000.0),
        ChartData(label: "f", value: 14086.0),
        ChartData(label: "m", value: 13370.0),
        ChartData(label: "a", value: 14807.0),
        ChartData(label: "m", value: 15308.0),
        ChartData(label: "j", value: 13902.0),
        ChartData(label: "j", value: 7500.0),
        ChartData(label: "a", value: 12050.0),
        ChartData(label: "s", value: 10000.0),
        ChartData(label: "o", value: 12000.0),
        ChartData(label: "n", value: 600.0),
        ChartData(label: "d", value: 0.0),
    ]
    
    @State static var selectedRange = 2
    static var previews: some View {
        BarChart(data: yearData1, selectedRange: $selectedRange)
    }
}
 
