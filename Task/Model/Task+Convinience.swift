//
//  Task+Convinience.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation

extension Task {
    
    @discardableResult
    convenience init(name: String, due: Date? = nil, notes: String? = nil) {
        self.init(context: CoreDataStack.context)
        
        self.name = name
        self.due = due
        self.notes = notes
        self.isComplete = false
    }
}
