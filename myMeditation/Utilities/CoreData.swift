//
//  CoreDataRelationshipViewModel.swift
//  CoreDataPractice
//
//  Created by Sebastian Banks on 9/25/21.
//

import Foundation
import CoreData
import Combine

class CoreData: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var savedSessionEntites: [MeditationSessionEntity] = []
    
    var time: Double = 0.0
    var run = 1
    var date = Date()
    
    init() {
        getSessions()
        
    }
    /*
    func testData() {
        let sun = Calendar.current.date(byAdding: .day, value: -5, to: date)
        let mon = Calendar.current.date(byAdding: .day, value: -4, to: date)
        let tues = Calendar.current.date(byAdding: .day, value: -3, to: date)
        let wed = Calendar.current.date(byAdding: .day, value: -2, to: date)
        let thur = Calendar.current.date(byAdding: .day, value: -1, to: date)
    
        
        addMeditationSession(time: 300.0, date: sun ?? date)
        addMeditationSession(time: 600.0, date: mon ?? date)
        addMeditationSession(time: 180.0, date: tues ?? date)
        addMeditationSession(time: 420.0, date: wed ?? date)
        addMeditationSession(time: 600.0, date: thur ?? date)
        addMeditationSession(time: 600.0, date: date)
        
    }
*/
    func getSessions() {
        let request = NSFetchRequest<MeditationSessionEntity>(entityName: "MeditationSessionEntity")
        
        do {
            savedSessionEntites = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching sessions. \(error.localizedDescription)")
        }
        
    }

    func addMeditationSession(time: Double, date: Date) {
        let newMeditationSession = MeditationSessionEntity(context: manager.context)
        
        newMeditationSession.timeMeditated = time
        newMeditationSession.date = date

        save()
    }
    
    func save() {
        manager.save()
//        getMeditation()
        getSessions()
    }
    
    func deleteSessionData(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedSessionEntites[index]
        manager.context.delete(entity)
        
        
        save()
    }
    
}



extension Date {
    
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0
    }
}
