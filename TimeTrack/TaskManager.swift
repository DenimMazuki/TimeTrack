//
//  TaskManager.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

class TaskManager {
    var toDoCount: Int {
        return toDoTask.count
    }
    var doneCount: Int {
        return doneTask.count
    }
    
    private var toDoTask: [Task] = []
    private var doneTask: [Task] = []
    
    func add(task: Task) {
        toDoTask.append(task)
    }
    
    func check(at index: Int) {
        let task = toDoTask.remove(at: index)
        doneTask.append(task)
    }
    
    func task(at index: Int) -> Task {
        
        return toDoTask[index]
    }
    
    func doneTask(at index: Int) -> Task {
        
        return doneTask[index]
    }
    
    func removeTask(at index: Int) {
        toDoTask.remove(at: index)
    }
    
    func removeDoneTask(at index: Int) {
        doneTask.remove(at: index)
    }
    
    func uncheck(at index: Int) {
        let task = doneTask.remove(at: index)
        toDoTask.append(task)
    }
}
