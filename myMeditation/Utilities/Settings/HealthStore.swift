//
//  HealthStore.swift
//  UserDefaultsPractice (iOS)
//
//  Created by Sebastian Banks on 10/29/21.
//

import Foundation
import HealthKit
import simd




class HealthStore {
    
    var healthStore = HKHealthStore()
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        }
        
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        
          
                let typestoShare = Set([
                    HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
                    ])
          
                let healthStore = HKHealthStore()
                healthStore.requestAuthorization(toShare: typestoShare, read: []) { (success, error) -> Void in
                    if(success){
                            // Read or write the HealthKit data
                    }
                    else{
                            // Authorization failure
                        print(error ?? "there was an error")
                    }
                }
        
        
        
    }
        
    
    func writeMindful(amount: Double) {

        
        let startDate = Date() - amount
        let endDate = Date()
        
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
        let mindfulSample = HKCategorySample(type: mindfulType, value: 0, start: startDate, end: endDate)
        healthStore.save(mindfulSample) { (success, error) -> Void in
            
            if error != nil {
                // something happened
                print("error in healthkit \(error?.localizedDescription ?? "error")")
                return
            }

            if success {
                print("My new data was saved in HealthKit \(success)")

            } else {
                // something happened again
                print("Health data not saved")
            }

        }
        

    }
    
}

    
