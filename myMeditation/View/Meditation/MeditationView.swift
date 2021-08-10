//
//  MeditationView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

struct MeditationView: View {
    
    @State var meditateTime = 60.0
    @State var meditateTimeRemaining = 60.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isMeditating = false
    @State var showMeditationProgress = false
    @State var showSheet: Bool = false
    
    func timeToString(time: Double, timeremaining: Double) -> String {
        var timeRemainingString: String = ""
        let hours = timeremaining/3600
        let minsMinusHours = hours.truncatingRemainder(dividingBy: 1)
        let mins = minsMinusHours * 60
        
        let wholehrs = Int(hours)
        let wholemins = Int(mins)
        
        if wholehrs > 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hrs"
        } else if wholehrs == 1 && wholemins == 0 {
            timeRemainingString = "\(wholehrs) hr"
        } else if wholehrs > 1 && wholemins >= 1{
            timeRemainingString = "\(wholehrs) hrs \(wholemins) mins"
        } else if wholehrs == 0 && wholemins >= 1{
            timeRemainingString = "\(wholemins) mins"
        } else {
            timeRemainingString = "\(Int(timeremaining)) sec"
        }
        
        
        return timeRemainingString
    }
    
    var body: some View {
        
        let buttonOpacity = showMeditationProgress ? 1.0 : 0.5
        
        ZStack {
            
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            
            VStack(spacing: 80) {
                
                if showMeditationProgress == false {
                
                    DurationPicker(duration: $meditateTime, remaining: $meditateTimeRemaining)
                        .colorScheme(.dark)
                        .transformEffect(.init(scaleX: 1.2, y: 1.2))
                        .offset(x: -32)
                    
                    
                } else {
                    VStack {
                        ProgressBar(progress: Float(meditateTimeRemaining / meditateTime), text: String(timeToString(time: meditateTime, timeremaining: meditateTimeRemaining)))
                            .frame(width: 300.0, height: 300.0)
                            .padding(20.0)
                    
                    
                    }
                }
                
                    
                HStack(spacing: 15) {
                    Button(action: {
                        if showMeditationProgress == true {
                            print("Timer Stopped")
                            showMeditationProgress = false
                            meditateTimeRemaining = meditateTime
                            isMeditating = false
                        } else {
                            print("Cancel Pressed")
                            
                            
                        }
                        
                            }) {
                        Text("Cancel")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding(5)
                    .frame(minWidth: 50, maxWidth: 120, minHeight: 50, maxHeight: 70)
                    .background(Color.init("ButtonColor"))
                    .clipShape(Capsule())
                    .opacity(buttonOpacity)
                        
                    Button(action: {
                        if showMeditationProgress == false {
                            print("start")
                            showMeditationProgress = true
                            isMeditating = true
                        } else {
                            print("pause")
                            isMeditating = false
                        }
                        
                        
                            }) {
                        if isMeditating == false {
                            Text("Start")
                                .font(.title)
                                .foregroundColor(.white)
                        } else {
                            Text("Pause")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(5)
                    .frame(minWidth: 50, maxWidth: 120, minHeight: 50, maxHeight: 70)
                    .background(Color.init("ButtonColor"))
                    .clipShape(Capsule())
                    .sheet(isPresented: $showSheet, content: {
                        MeditationCompleteView()
                    })
                    
                }
            }
        }.onReceive(timer) { time in
            guard self.isMeditating else {return}
            
            if self.meditateTimeRemaining > 0 {
                self.meditateTimeRemaining -= 1
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in self.isMeditating = false
            
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in isMeditating = true
        }
    }
}
    



struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
            
    }
}
    
