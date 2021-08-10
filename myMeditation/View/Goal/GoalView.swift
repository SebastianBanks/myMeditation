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
            
            VStack {
            HStack {
                                Button(action: { print("meditate") }) {
                                    VStack {
                                    Image(systemName: "dollarsign.circle.fill")
                                        .padding(5)
                                        .font(.system(size: 50))
                                        .foregroundColor(Color.init("TextColor"))
                                    Text("Donate")
                                        .bold()
                                        .padding(1)
                                        .font(.title)
                                        .foregroundColor(Color.init("TextColor"))
                                        
                                        
                                    }
                                }
                                .frame(width: 150, height: 150)
                                .padding()
                                .background(Color.init("WidgetColor"))
                                .cornerRadius(40)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                
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
                                .frame(width: 150, height: 150)
                                .padding()
                                .background(Color.init("WidgetColor"))
                                .cornerRadius(40)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                
                                
                            }
            HStack {
                                Button(action: { print("meditate") }) {
                                    VStack {
                                    Image(systemName: "dollarsign.circle.fill")
                                        .padding(5)
                                        .font(.system(size: 50))
                                        .foregroundColor(Color.init("TextColor"))
                                    Text("Donate")
                                        .bold()
                                        .padding(1)
                                        .font(.title)
                                        .foregroundColor(Color.init("TextColor"))
                                        
                                        
                                    }
                                }
                                .frame(width: 150, height: 150)
                                .padding()
                                .background(Color.init("WidgetColor"))
                                .cornerRadius(40)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                
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
                                .frame(width: 140, height: 140)
                                .padding()
                                .background(Color.init("WidgetColor"))
                                .cornerRadius(40)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                
                                
                            }
            }
            .frame(minWidth: 250, idealWidth: 300, maxWidth: .infinity, minHeight: 250, idealHeight: 300, maxHeight: 350, alignment: .center)

            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
