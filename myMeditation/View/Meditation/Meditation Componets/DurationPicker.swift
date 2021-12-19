//
//  DurationPicker.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/14/21.
//

import SwiftUI

struct DurationPicker: UIViewRepresentable {
    @Binding var duration: Double

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.minuteInterval = 1
        datePicker.countDownDuration = duration
        datePicker.addTarget(context.coordinator, action: #selector(DurationPicker.Coordinator.updateDuration), for: .allEvents)
        
        duration = datePicker.countDownDuration
        
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        duration = datePicker.countDownDuration
    }

    func makeCoordinator() -> DurationPicker.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIPickerViewDelegate {
        let parent: DurationPicker

        init(_ parent: DurationPicker) {
            self.parent = parent
        }
        
        /*
    @IBAction func updateDuration(sender: UIDatePicker, forEvent event: UIEvent) {
        
                parent.duration = sender.countDownDuration
            }
        */
        
        
        @objc func updateDuration(datePicker: UIDatePicker) {
            let countdown = datePicker.countDownDuration
            datePicker.countDownDuration = countdown
            parent.duration = datePicker.countDownDuration
            
        }
        
    }
}
