//
//  DataController.swift
//  Velk
//
//  Created by Dom Parsons on 21/08/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Velk")
        
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    init() {
    }
    
    static var preview: DataController = {
        let controller = DataController()
        return controller
    }()
}
