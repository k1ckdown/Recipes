//
//  CoreDataManager.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Recipes")
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private let persistentContainer: NSPersistentContainer
    
    private init(modelName: String) {
        persistentContainer = .init(name: modelName)
    }
    
    func loadStore(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data store failed to load: \(error)")
            }
        }
    }
    
}
