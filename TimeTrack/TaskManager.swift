//
//  TaskManager.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

class TaskManager {
    var toDoCount: Int
    var doneCount: Int
    
    func add(task: Task) {
        toDoCount += 1
    }
    
    func check(at: Int) {
        toDoCount -= 1
        doneCount += 1
    }
    
    init() {
        toDoCount = 0
        doneCount = 0
    }
}
