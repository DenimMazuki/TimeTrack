//
//  DayManagerTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class DayManagerTests: XCTestCase {
    
    var sut: DayManager!
    
    override func setUp() {
        
        super.setUp()
        
        sut = DayManager()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_AddingNewDay_ToEmptyManagerHasSize1() {
        
        XCTAssertEqual(sut.numberOfDays(), 0)
        
        sut.addNewDay()
        
        XCTAssertEqual(sut.numberOfDays(), 1)
    }
    
    func test_AddingNewDay_HasSameDate() {
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter
        }()
        
        sut.addNewDay()
        
        XCTAssertEqual(sut.latestDay().getDate(), dateFormatter.string(from: Date()))
        
    }
    
}
