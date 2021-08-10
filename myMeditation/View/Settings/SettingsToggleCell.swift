//
//  SettingsToggleCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/8/21.
//

import SwiftUI

struct SettingsToggleCell: View {
    var title: String
    var imgName: String
    @Binding var toggle: Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(Color.init("ButtonColor"))
            
            Text(title)
                .padding(.leading, 10)
                .foregroundColor(Color.init("TextColor"))
            
            Spacer()
            
            Toggle(isOn: $toggle, label: {
                Text("")
            })
        }
    }
}
