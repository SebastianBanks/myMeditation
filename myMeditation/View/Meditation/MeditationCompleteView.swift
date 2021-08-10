//
//  MeditationCompleteView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 8/7/21.
//

import SwiftUI

struct MeditationCompleteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            
            
            
            
            VStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                })
                .frame(minWidth: 44, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .topLeading)
                .padding()
                .padding(.top, -40)
                .padding(.bottom, 80)
                
                
                Text("10 mins meditated")
                    .font(.largeTitle.bold())
                    .padding()
                    
                    .foregroundColor(.white)
                    .frame(minWidth: 44, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 75, maxHeight: 80, alignment: .leading)
                Text("🔥 0")
                    .padding()
                    .offset(y: -30)
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.white)
                    .frame(minWidth: 44, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 70, idealHeight: 75, maxHeight: 80, alignment: .leading)
                
                VStack {
                    Button(action: { print("goals button") }) {
                        Text("Goals")
                            .font(.system(size: 45))
                            .bold()
                            .foregroundColor(Color.init("TextColor"))
                            .padding()
                            .frame(width: 190, height: 50, alignment: .leading)
                            .position(x: 85, y: 40)
                    }
                }
                .frame(minWidth: 200, idealWidth: 320, maxWidth: .infinity, minHeight: 200, idealHeight: 250, maxHeight: 300, alignment: .center)
                .padding()
                .background(Color.init("WidgetColor"))
                .cornerRadius(40)
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                    
            }
        }
        
    }
}

struct MeditationCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationCompleteView()
    }
}
