//
//  SettingsCell.swift
//  UserDefaultsPractice
//
//  Created by Sebastian Banks on 10/1/21.
//

import SwiftUI

struct SettingsCell: View {
        var title: String
        var imgName: String
        
        
        var body: some View {
            
            HStack {
                Image(systemName: imgName)
                    .font(.headline)
                    .foregroundColor(Color.init("BarColor"))
                
                Text(title)
                    .padding(.leading, 10)
                    .foregroundColor(Color.init("TextColor"))
                
                Spacer()
            }
        }
    }



