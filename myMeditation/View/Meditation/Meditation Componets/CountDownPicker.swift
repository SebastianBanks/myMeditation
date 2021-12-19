//
//  CountDownPicker.swift
//  myMeditation
//
//  Created by Sebastian Banks on 12/3/21.
//

import SwiftUI

struct CountDownPicker: View {
    
    var hours = Array(0...23)
    var min = Array(0...59)
    
    @Binding var selectedHours: Int
    @Binding var selectedMins: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Picker(selection: $selectedHours, label: Text("hrs")) {
                    ForEach(0..<self.hours.count) {
                        Text("\(self.hours[$0]) hrs")
                            .bold()
                    }
                }
                .frame(maxWidth: geometry.size.width / 2)
                .clipped()
                .pickerStyle(.wheel)
                
                Picker(selection: self.$selectedMins, label: Text("mins")) {
                    ForEach(0..<self.min.count) {
                        Text("\(self.min[$0]) mins")
                            .bold()
                    }
                }
                .frame(maxWidth: geometry.size.width / 2)
                .clipped()
                .pickerStyle(.wheel)
            }
        }
        .offset(y: -100)
        .padding()
        .frame(width: 350, height: 140, alignment: .center)
        
    }
}

/*
struct CountDownPicker_Previews: PreviewProvider {
    @State var hours = 0
    @State var min = 0
    
    static var previews: some View {
        CountDownPicker(selectedHours: $hours, selectedMins: $min)
    }
}
*/
