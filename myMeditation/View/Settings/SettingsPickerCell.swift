//
//  SettingsCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/24/21.
//

import SwiftUI

struct SettingsPickerCell: View {
    
    var title: String
    var imgName: String
    var pickerName: String = ""
    var items: [String]
    @Binding var selected: String
    
    
    var body: some View {
        
        HStack {
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(Color.init("ButtonColor"))
            
            Text(title)
                .padding(.leading, 10)
                .foregroundColor(Color.init("TextColor"))
            
            Spacer()
            
            Picker(pickerName, selection: $selected) { ForEach(items, id: \.self) {
                Text($0)
                }
            }

        }
    }
}


