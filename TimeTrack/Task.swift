//
//  Task.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

struct Task: Equatable {
    let title: String
    let timeSpent: Double
    let dateCreated: String
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    init(title: String) {
        self.title = title
        self.timeSpent = 0.0
        self.dateCreated = dateFormatter.string(from: Date())
    }
}

func ==(lhs: Task, rhs: Task) -> Bool {
    if (lhs.title != rhs.title) {
        return false
    }
    
    if (lhs.timeSpent != rhs.timeSpent) {
        return false
    }
    
    if (lhs.dateCreated != rhs.dateCreated) {
        return false
    }
    
    return true
}
