//
//  ContentView.swift
//  MyMeditation
//
//  Created by Sebastian Banks on 7/3/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        let username = "Sebastian"
        
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            
            VStack {
                HStack{
                    Image("LogoImage")
                        .resizable()
                        .offset(y: 00)
                        .frame(width: 100, height: 100, alignment: .center)
                }
                VStack {
                    Text("Welcome \(username),")
                        .padding()
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.white)
                        .frame(width: 400, height: 60, alignment: .leading)
                    Text("🔥 0")
                        .padding()
                        .padding(.top, -40)
                        .font(.largeTitle.bold())
                        .foregroundColor(Color.white)
                        .frame(width: 400, height: 40, alignment: .leading)
                }
                .frame(minWidth: 350, idealWidth: 350, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 60, idealHeight: 100, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top, 30)
                
                HStack {
                    VStack {
                        Button(action: { print("meditate") }) {
                            Text("Meditate")
                                .font(.system(size: 45))
                                .bold()
                                .foregroundColor(Color.init("TextColor"))
                                .frame(width: 190, height: 50, alignment: .leading)
                                .position(x: 85, y: 40)
                    }
                    
                        VStack {
                        HStack {
                            Text("10 mins")
                                .font(.title)
                                .foregroundColor(Color.init("TextColor"))
                                .bold()
                            Button(action: { print("inside button") }) {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.init("ButtonColor"))
                                
                                        
                            }
                            .padding(10)
                            .frame(width: 60, height: 60, alignment: .center)

                        }
                        .position(x: 100, y: 50)
                        }
                    }
                    .frame(width: 170, height: 150)
                    .padding()
                    .background(Color.init("WidgetColor"))
                    .cornerRadius(40)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    
                    Button(action: { print("meditate") }) {
                        VStack {
                        Image(systemName: "graduationcap.fill")
                            .padding(5)
                            .font(.system(size: 50))
                            .foregroundColor(Color.init("TextColor"))
                        Text("Learn")
                            .bold()
                            .padding(5)
                            .font(.title)
                            .foregroundColor(Color.init("TextColor"))
                            
                        }
                    }
                    .frame(width: 100, height: 150)
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
                    .frame(width: 100, height: 150)
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
                    .frame(width: 170, height: 150)
                    .padding()
                    .background(Color.init("WidgetColor"))
                    .cornerRadius(40)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
//                .environment(\.colorScheme, .dark)
        }
    }
}
