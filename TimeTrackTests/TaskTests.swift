//
//  TaskTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class TaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_WhenGivenTitle_SetsTitle() {
        
        let task = Task(title: "Code")
        
        XCTAssertEqual(task.title, "Code")
    }
    
    func test_Init_WhenTaskIsCreated_HasInitialTimeSpentOfZero() {
        
        let task = Task(title: "Code")
        
        XCTAssertEqual(task.timeSpent, 0.0)
    }
    
    func test_Init_WhenTaskIsCreated_SetsATimeStampOfDateCreated() {
        
        let task = Task(title: "Code")
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter
        }()
        
        XCTAssertEqual(task.dateCreated, dateFormatter.string(from: Date()))
    }
    
    
    func test_CreateTwoTaskWithSameTitleOnSameDay_ShouldEqual() {
        let firstTask = Task(title: "Code")
        let secondTask = Task(title: "Code")
        
        XCTAssertEqual(firstTask, secondTask)
    }
    
    func test_CreateTwoTaskWithDifferentTitleOnSameDay_ShouldNotEqual() {
        let firstTask = Task(title: "Code")
        let secondTask = Task(title: "Sleep")
        
        XCTAssertNotEqual(firstTask, secondTask)
    }
}
