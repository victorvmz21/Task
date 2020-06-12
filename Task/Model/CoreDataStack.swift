//
//  CoreDataStack.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Task")
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Loading Error \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
