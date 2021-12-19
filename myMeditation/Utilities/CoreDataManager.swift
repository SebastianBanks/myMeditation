//
//  CoreDataManager.swift
//  CoreDataPractice
//
//  Created by Sebastian Banks on 9/25/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved Core Data successfully")
            print("time: \(CoreData().time)")
        } catch let error {
            print("Error saving Core Data \(error.localizedDescription)")
        }
    }
}
