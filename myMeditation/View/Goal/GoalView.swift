//
//  GoalView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct GoalView: View {
    var body: some View {
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            NavigationView{
                ScrollView{
                    VStack(spacing: 30) {
                        GoalChartView(buttonText: "Hello World")
                            .padding(.top, 30)
                        EditGoalButtonView()
                        GoalWidgetView(buttonText: "Hello World")
                        GoalWidgetView(buttonText: "Hello World")
                        GoalWidgetView(buttonText: "Hello World")
                    }
                }.navigationTitle("Goals")
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
