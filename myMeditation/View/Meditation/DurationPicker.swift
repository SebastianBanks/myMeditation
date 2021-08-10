//
//  DurationPicker.swift
//  myMeditation
//
//  Created by Sebastian Banks on 7/14/21.
//

import SwiftUI

struct DurationPicker: UIViewRepresentable {
    @Binding var duration: TimeInterval
    @Binding var remaining: TimeInterval

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.countDownDuration = duration
        datePicker.countDownDuration = remaining
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: DurationPicker

        init(_ parent: DurationPicker) {
            self.parent = parent
        }

        @objc func updateDuration(datePicker: UIDatePicker) {
            parent.duration = datePicker.countDownDuration
            parent.remaining = datePicker.countDownDuration
        }
    }
}
