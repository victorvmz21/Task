//
//  DateHelpers.swift
//  Task
//
//  Created by Victor Monteiro on 6/11/20.
//  Copyright © 2020 Atomuz. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
