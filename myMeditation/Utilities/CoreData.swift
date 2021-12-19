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
    @Published var savedGoalsEntites: [GoalsEntity] = []
    var time: Double = 0.0
    var run = 1
    var date = Date()
    
    init() {
        getSessions()
    }
    
    func getGoals() {
        let request = NSFetchRequest<GoalsEntity>(entityName: "GoalsEntity")
        
        do {
            savedGoalsEntites = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching goals. \(error.localizedDescription)")
        }
    }
    
    func addGoals(sun: Bool, mon: Bool, tues: Bool, wed: Bool, thur: Bool, fri: Bool, sat: Bool) {
        
        for entite in savedGoalsEntites {
            manager.context.delete(entite)
        }
        
        let newGoals = GoalsEntity(context: manager.context)
        
        newGoals.sunMeditate = sun
        newGoals.monMeditate = mon
        newGoals.tuesMeditate = tues
        newGoals.wedMeditate = wed
        newGoals.thurMeditate = thur
        newGoals.friMeditate = fri
        newGoals.satMeditate = sat
        
        save()
    }

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
