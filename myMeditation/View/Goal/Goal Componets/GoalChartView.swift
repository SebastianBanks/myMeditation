//
//  GoalChartView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/20/21.
//

import SwiftUI

struct GoalChartView: View {
    
    @Binding var data: [ChartData]
    @Binding var selectedRange: Int
    
    var body: some View {
        VStack {
            Picker(selection: $selectedRange, label: Text("")) {
                Text("Week").tag(0)
                Text("Month").tag(1)
                Text("Year").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .frame(width: 350)
            
            BarChart(data: data, selectedRange: $selectedRange)
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .frame(width: 350, height: 350)
            .foregroundColor(Color.init("TextColor"))
            .background(
                ZStack {
                    Color.init("BackgroundColor")
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundColor(.clear)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.init("BackgroundColor"), Color.init("WidgetColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            .shadow(color: Color("DarkShadow"), radius: 20, x: 20, y: 20)
            .shadow(color: Color("LightShadow"), radius: 20, x: -20, y: -20)
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

/*
struct GoalChartView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let banna = [
            ChartData(label: "Sun", value: 10.0),
            ChartData(label: "Mon", value: 15.0),
            ChartData(label: "Tues", value: 0.0),
            ChartData(label: "Wed", value: 11.0),
            ChartData(label: "Thur", value: 20.0),
            ChartData(label: "Fri", value: 0.0),
            ChartData(label: "Sat", value: 5.0)
        ]
        
        GoalChartView(data: banna)
    }
}
*/
