//
//  MeditationView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

@available(iOS 15, *)
struct MeditationView: View {
    
    
    var coreHaptics = CoreHaptics()
    @ObservedObject var meditationViewModel = MeditationViewModel()
    
    @State var meditateTime = 0.0
    @State var isMeditating = false
    @State var pauseButton = true
    
    @State var hours = 0
    @State var mins = 5
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        
        ZStack {
            Color.init("BackgroundColor").ignoresSafeArea(.all)
            VStack(spacing: 80) {
                
                if isMeditating == false {
                
                    CountDownPicker(selectedHours: $hours, selectedMins: $mins)
                        .offset(y: 25)
                    
                    /*
                    DurationPicker(duration: $meditateTime)
                        .transformEffect(.init(scaleX: 1.2, y: 1.2))
                        .offset(x: -32)
                    */
                } else {
                    VStack {
                        ProgressBar(progress: $meditationViewModel.progress, text: $meditationViewModel.progressText)
                            .frame(width: 300.0, height: 300.0)
                            .padding(20.0)
                    }
                }
                    
                HStack(spacing: 30) {
                    Button(action: {
                        
                        meditationViewModel.cancel()
                        
                        print("is meditating: \(meditationViewModel.isMeditating)")
                    }) {
                        ButtonsView(buttonText: "Cancel")
                    }
                    .frame(width: 120, height: 90)
                    .opacity(meditationViewModel.isMeditating ? 1.0 : 0.5)
                    .disabled(meditationViewModel.isMeditating ? false : true)
                        
                    Button(action: {
                        let meditatehours = Double(hours) * 3600
                        let meditatemins = Double(mins) * 60
                        let meditation = meditatehours + meditatemins
                        meditationViewModel.startPauseButton(time: meditation)
                        
                        
                        print("Meditate Time: \(meditateTime)")
                            }) {
                                ButtonsView(buttonText: meditationViewModel.startPauseString())
                    }
                    .frame(width: 120, height: 90)
                    
                    
                }
            }
        }
        .onReceive(meditationViewModel.$isMeditating) { bool in
            self.isMeditating = bool
        }
        .onChange(of: hours, perform: { value in
            meditationViewModel.meditateHourPicker = hours
        })
        .onChange(of: mins, perform: { value in
            meditationViewModel.meditateMinPicker = mins
        })
        .onChange(of: scenePhase, perform: { phase in
            switch phase {
            case .background:
                print("App went to background")
                if isMeditating == true {
                    meditationViewModel.appEnteredBackground(isMeditating: isMeditating)
                }
                
            case .active:
                print("App became active or came to foreground")
                meditationViewModel.appEnteredForeground()
                self.meditateTime = meditationViewModel.meditateTime
                self.isMeditating = meditationViewModel.isMeditating
                self.pauseButton = meditationViewModel.pause
                print("meditatetime: \(meditateTime)")
                print("isMeditating: \(isMeditating)")
                print("pauseButton: \(pauseButton)")
            case .inactive:
                print("App became inactive")
                meditationViewModel.saveTimeRemaining(timeRemaining: meditationViewModel.timeRemaining)
            @unknown default:
                print("Well, something certainly happened...")
                meditationViewModel.resetMeditationValues()
                self.meditateTime = meditationViewModel.meditateTime
                self.isMeditating = meditationViewModel.isMeditating
                self.pauseButton = meditationViewModel.pause
            }
        })
        .onAppear(perform: {
            self.meditateTime = meditationViewModel.meditateTimePersist
            self.isMeditating = meditationViewModel.isMeditatingPersist
            self.pauseButton = meditationViewModel.pausePersist
            print("\(meditateTime)")
            print("\(isMeditating)")
            print("\(pauseButton)")
        })
        .onAppear(perform: {
            self.hours = meditationViewModel.meditateHourPicker
            self.mins = meditationViewModel.meditateMinPicker
        })
        .sheet(isPresented: $meditationViewModel.isDone, content: {
            MeditationCompleteView(showSheet: $meditationViewModel.isDone,  timeMeditated: $meditationViewModel.timeMeditated)
        })
        .onDisappear(perform: {
            meditationViewModel.isMeditatingOnDisappear(isMeditating: isMeditating)
        })
    }
    
}
    



@available(iOS 15, *)
struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
            
    }
}
    
