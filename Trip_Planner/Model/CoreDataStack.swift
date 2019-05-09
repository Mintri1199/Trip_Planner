//
//  CoreDataStack.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import CoreData

class TripStore: NSObject {
    let persistentContainer: NSPersistentContainer = {
        // creates the NSPersistentContainer object
        // must be given the name of the Core Data model file “LoanedItems”
        let container = NSPersistentContainer(name: "Trip_Planner")
        
        // load the saved database if it exists, creates it if it does not, and returns an error under failure conditions
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchPersistedData(completion: (Result<[TripPersistent], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TripPersistent> = TripPersistent.fetchRequest()
        let viewContext = persistentContainer.viewContext
        
        do {
            let allTrips = try viewContext.fetch(fetchRequest)
            completion(.success(allTrips))
        } catch {
            completion(.failure(error))
        }
    }
}
