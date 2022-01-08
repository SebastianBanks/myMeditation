//
//  HealthButton.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 11/2/21.
//

import SwiftUI
import HealthKit


struct HealthButton: View {
    
    var title: String
    var imgName: String
    var popup = false

    @ObservedObject var settingsViewModel = SettingsViewModel()
    @Binding var image: Image
    
    
    var body: some View {
        
            HStack {
                Image(systemName: imgName)
                    .font(.headline)
                    .foregroundColor(Color.init("BarColor"))
                
                Text(title)
                    .padding(.leading, 10)
                    .foregroundColor(Color.init("TextColor"))
                
                Spacer()
                
                settingsViewModel.addImageModifiers(image: image)
                 
            }
       
    }

}



/*
struct HealthButton: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        configuration.label
        HStack {
            Image(systemName: "heart")
                .font(.headline)
                .foregroundColor(.red)
            
            Text("Apple Health")
                .padding(.leading, 10)
                .foregroundColor(.black)
            
            Spacer()
        }
        
    }
}
*/


