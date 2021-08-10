//
//  SettingsCell.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/8/21.
//

import SwiftUI

struct SettingsCell: View {
        var title: String
        var imgName: String
        
        
        var body: some View {
            
            HStack {
                Image(systemName: imgName)
                    .font(.headline)
                    .foregroundColor(Color.init("ButtonColor"))
                
                Text(title)
                    .padding(.leading, 10)
                    .foregroundColor(Color.init("TextColor"))
                
                Spacer()
            }
        }
    }


