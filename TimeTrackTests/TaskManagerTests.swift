//
//  TaskManagerTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUp() {
        super.setUp()
        
        sut = TaskManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_toDoTask_IsInitiallyZero() {
        
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_toDoTask_IsOneAfterAddingOneTask() {
        
        sut.add(task: Task(title: "Code"))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_completedTask_IsInitiallyZero() {
        
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_completedTask_IsOneAfterCompletingOneTask() {
        
        sut.add(task: Task(title: "Code"))
        sut.check(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItem_MovesToDoItemToDoneItem() {
        
        sut.add(task: Task(title: "Code"))
        sut.check(at: 0)
        XCTAssertEqual(sut.doneTask(at: 0), Task(title:"Code"))
    }
    
    
    
}
