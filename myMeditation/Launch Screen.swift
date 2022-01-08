//
//  Launch Screen.swift
//  myMeditation
//
//  Created by Sebastian Banks on 1/6/22.
//

import SwiftUI

struct Launch_Screen: View {
    
    var animation: Animation = Animation.linear.repeatForever(autoreverses: false)
    var isRotated = true
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea(.all)
            VStack {
                Image.init("LogoImage")
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding()
                    .rotationEffect(Angle.degrees(isRotated ? 10 : 0))
                    .animation(animation, value: 10)
                    
                
                Text("myMeditation")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .bold()
                    
            }
        }
    }
}

struct Launch_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Launch_Screen()
    }
}
