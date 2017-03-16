//
//  PomodoroTimerTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/16/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class PomodoroTimerTests: XCTestCase {
    
    var sut: PomodoroTimer!

    
    override func setUp() {
        super.setUp()
        sut = PomodoroTimer()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Timer_StartsAtBreakCase() {
        
        XCTAssertTrue(sut.currentMode == PomodoroModes.Break)
    }
    
    func test_Timer_StartsWithInitialTimeOf25() {
        
        XCTAssertTrue(sut.timeLeft == 25.0)
    }
    
    func test_Timer_StartsNotActive() {
        
        XCTAssertTrue(!sut.isActive)
    }
    
    func test_Timer_AfterInit_IsActive() {
        
        sut.initTimer()
        
        XCTAssertTrue(sut.isActive)
    }
    
    
    func test_AfterInit_WhenTimeLeftIsZero_StartsBreak() {
        
        let mockTimer = MockPomodoroTimer()
        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        
        mockTimer.completionHandler = {
            _ in
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.initTimer()
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        XCTAssertTrue(mockTimer.currentMode == PomodoroModes.Break)
        XCTAssertTrue(mockTimer.isActive)
    }
    
    func test_Init_AtEndOfABreak_SetsTimeToWorkAndIsInactive() {
        
        let mockTimer = MockPomodoroTimer()
        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        mockTimer.completionHandler = {
            _ in
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.currentMode = PomodoroModes.Break
        mockTimer.isActive = true
        
        mockTimer.initTimer()
        waitForExpectations(timeout: 3.0, handler: nil)
        
        XCTAssertTrue(mockTimer.currentMode == PomodoroModes.Break)
        XCTAssertTrue(mockTimer.timeLeft == mockTimer.shorterWork)
        XCTAssertFalse(mockTimer.isActive)
        
    }
    
    
    
}

extension PomodoroTimerTests {
    
    class MockPomodoroTimer: PomodoroTimer {
        
        // Mock Timer will have shorter down time to test: 2 second for work and 1 second for break
        var shorterBreak: Double = 2.0
        var shorterWork: Double = 2.0
        var timerWentZero: Bool = false
        
        var completionHandler: (()->())?
        
        override func initTimer() {
            // If current case is on break, starting timer will set it to work
            
            if (currentMode == PomodoroModes.Break) {
                currentMode = PomodoroModes.Work
            }
            
            if (!isActive) {
                
                isActive = true
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                    _ in self.countDown()
                    
                }
            } else {
                timeLeft = shorterWork
                // If already active: depends on two case
                if (currentMode == PomodoroModes.Break) {
                    currentMode = PomodoroModes.Work
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                        _ in self.countDown()
                        
                    }
                } else {
                    
                    isActive = false
                    currentMode = PomodoroModes.Break
                }
                
                
            }
            
        }
        
        @objc override func countDown() {
            
            if (timeLeft > 0) {
                timeLeft -= 1.0
            } else {
                
                timerWentZero = true
                completionHandler!()
                if (currentMode == PomodoroModes.Break) {
                    // If timer finishes and its a break, reset to fresh start (2)
                    timeLeft = shorterWork
                    isActive = false
                    timer.invalidate()
                } else {
                    // If timer finishes and its a work, reset to break (5)
                    timeLeft = shorterBreak
                    currentMode = PomodoroModes.Break
                }
                
            }
            
        }
        
        override init() {
            
            super.init()
            
            timeLeft = shorterWork
        }
        
        
    }
    
}
