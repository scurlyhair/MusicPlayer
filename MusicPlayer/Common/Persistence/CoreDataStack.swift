//
//  CoreDataStack.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/6.
//  Copyright © 2020 yunhui wu. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    /// Background queue
    lazy var backgroundQueue: DispatchQueue = DispatchQueue(label: "core_data")
    
    /// Main queue context
    lazy var mainContext: NSManagedObjectContext? = {
        if let coordinator = storeCoordinator {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        }
        Console.logError("Construct mainContext failed!")
        return nil
    }()
    
    /// Store Coordinator
    private lazy var storeCoordinator: NSPersistentStoreCoordinator? = {
        if let model = managedObjectModel, let descriptions = storeDescriptions {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            
            for description in descriptions {
                coordinator.addPersistentStore(with: description) { (description, error) in
                    if let error = error {
                        fatalError("CoreDtaStack - Error adding store to storeCoordinator, \(error.localizedDescription)")
                    }
                }
            }
            return coordinator
        }
        Console.logError("Construct storeCoordinator failed!")
        return nil
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        if let URL = Bundle.main.url(forResource: "MusicPlayer", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: URL) {
            return model
        }
        Console.logError("Construct managedObjectModel failed!")
        return nil
    }()
    
    private lazy var storeDescriptions: [NSPersistentStoreDescription]? = {
        var descriptions: [NSPersistentStoreDescription] = []
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let description = NSPersistentStoreDescription()
            description.url = documentURL.appendingPathComponent("MusicPlayer.sqlite")
            description.type = NSSQLiteStoreType
            descriptions.append(description)
        }
        if descriptions.count > 0 {
            return descriptions
        }
        Console.logError("Construct storeDescriptions failed!")
        return nil
    }()
}
