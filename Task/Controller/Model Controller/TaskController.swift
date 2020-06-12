//
//  TaskController.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK: Properties
    static var shared = TaskController()
    
    let fetchResultController: NSFetchedResultsController<Task>
    
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        let resultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        self.fetchResultController = resultController
        
        do{
            try fetchResultController.performFetch()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    var mockTask: [Task] {
        let washDishes = Task(name: "Wash dishes", due: Date(), notes: "Dont forget to wash the dishes")
        let clean = Task(name: "Clean The House", due: Date(), notes: "ASAP")
        return [washDishes,clean]
    }
    
    func buttonIsToggled(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    //MARK: CRUD
    func add(taskWithName name: String, notes: String?, due: Date?) {
        Task(name: name, due: due, notes: notes)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("CoreData Could Not save \(error.localizedDescription)")
        }
    }
}
