//
//  MeditationView.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/6/21.
//

import SwiftUI

@available(iOS 15, *)
struct MeditationView: View {
    
    
    
    @ObservedObject var meditationViewModel = MeditationViewModel()
    
    @State var meditateTime = 0.0
    @State var isMeditating = false
    @State var pauseButton = true
    
    @State var hours = 0
    @State var mins = 5
    
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
        .sheet(isPresented: $meditationViewModel.isDone, content: {
            MeditationCompleteView(showSheet: $meditationViewModel.isDone,  timeMeditated: $meditationViewModel.timeMeditated)
        })
        
    }
    
}
    



@available(iOS 15, *)
struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
            
    }
}
    
