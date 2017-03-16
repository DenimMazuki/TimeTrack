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
    
    var mockTimer: MockPomodoroTimer!
    var mockDayManager: MockDayManager!
    
    override func setUp() {
        super.setUp()
        sut = PomodoroTimer()
        mockTimer = MockPomodoroTimer()
        mockDayManager = MockDayManager()
        mockTimer.dayManager = mockDayManager
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
    
    
    func test_AfterInit_WhenWorkTimeLeftIsZero_StartsBreak() {

        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        
        mockTimer.completionHandler = {
            _ in
            
            //self.mockTimer.timer.invalidate()
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.initTimer()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        //XCTAssertTrue(mockTimer.currentMode == PomodoroModes.Break)
        XCTAssertTrue(mockTimer.isActive)
    }
    
    func test_Init_AtEndOfABreak_SetsTimeToWorkAndIsInactive() {

        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        mockTimer.completionHandler = {
            _ in
            self.mockTimer.timer.invalidate()
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.currentMode = PomodoroModes.Break
        mockTimer.isActive = false
        
        mockTimer.initTimer()
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertTrue(mockTimer.currentMode == PomodoroModes.Break)
        XCTAssertTrue(mockTimer.timeLeft == mockTimer.shorterWork)
        XCTAssertFalse(mockTimer.isActive)
        
    }
    
    func test_Init_AtEndOfWork_PomodoroIncreasesByOne() {
        
        XCTAssertTrue(mockTimer.dayManager?.latestDay().getPomodoroCompleted() == 0)
        
        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        
        mockTimer.completionHandler = {
            _ in
            self.mockTimer.timer.invalidate()
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.initTimer()
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        XCTAssertTrue(mockTimer.dayManager?.latestDay().getPomodoroCompleted() == 1)
        
    }
    
    func test_Init_AtEndOfEveryFourSession_SetsLongBreak() {

        let timerWentZeroExpectation = expectation(description: "timer went to zero")
        mockTimer.completionHandler = {
            _ in
            self.mockTimer.timer.invalidate()
            timerWentZeroExpectation.fulfill()
        }
        
        mockTimer.dayManager = MockDayManager()
        
        // Increase latest day pomodoro to 3
        for _ in 1...3 {
            mockTimer.dayManager?.increaseLatestDayPomodoroCount()
        }
        
        XCTAssertTrue(mockTimer.dayManager?.latestDay().getPomodoroCompleted() == 3)
        
        mockTimer.initTimer()
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertEqual(mockTimer.timeLeft, mockTimer.longerBreak)
        
    }
    
}

extension PomodoroTimerTests {
    
    class MockDayManager: DayManager {
        
        override init() {
            super.init()
            
            self.addNewDay()
        }
    }
    
    class MockPomodoroTimer: PomodoroTimer {
        
        // Mock Timer will have shorter down time to test: 2 second for work and 1 second for break
        var shorterBreak: Double = 2.0
        var longerBreak: Double = 3.0
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
                    timer.invalidate()
                    isActive = false
                } else {
                    // If timer finishes and its a work, reset to break (5)
                    
                    dayManager?.increaseLatestDayPomodoroCount()
                    currentMode = PomodoroModes.Break
                    
                    if (dayManager?.latestDay().getPomodoroCompleted() != 0 && (dayManager?.latestDay().getPomodoroCompleted())! % 4 == 0) {
                        timeLeft = longerBreak
                    } else {
                        timeLeft = shorterBreak
                    }
                }
            }
            
        }
        
        override init() {
            
            super.init()
            
            timeLeft = shorterWork
        }
        
        
    }
    
}
