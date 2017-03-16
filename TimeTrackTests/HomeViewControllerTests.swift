//
//  HomeViewControllerTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    var startButton: UIButton?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        sut = viewController as! HomeViewController
        
        _ = sut.view
        
        startButton = sut.startButton
        
         UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HomeVC_ContainsStartButton() {
        
        XCTAssertNotNil(startButton)
    }
    
    func test_HomeVC_ContainsTableViewAfterViewDidLoad() {
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource is TaskDataProvider)
    }
    
    func test_PomodoroLabel_InitiallyIsSetToZero() {
        
        XCTAssertEqual(sut.pomodoroLabel.text, "0")
    }
    
    func test_PomodoroLabel_IncreasingLatestPomodoroIncreasesToOne() {
        
        sut.increaseLatestDayPomodoro()
        
        XCTAssertEqual(sut.pomodoroLabel.text, "1")
    }
    
    func test_StartButton_ChangesTextToStopWhenPressed() {
        
        XCTAssertNotNil(sut.startButton)
        
        let button = sut.startButton
        
        XCTAssertNotNil(button)
        
        sut.startStopButtonPressed(button!)
        
        XCTAssertEqual(button?.titleLabel?.text, "Stop")
    }
    
    func test_StartButton_IfClickedTwiceTextIsSetToStart() {
        
        
        
        sut.startStopButtonPressed(startButton!)
        sut.startStopButtonPressed(startButton!)
        
        XCTAssertEqual(startButton?.titleLabel?.text, "Start")
    }
    
    func test_Timer_ContainsSameDayManagerAsHomeVC() {
        
        XCTAssertTrue(sut.dayManager === sut.pomodoroTimer.dayManager!)
    }
    
    func test_StartButton_IfClickedOnce_BeginsCountingDownTimer() {
        
        
        let timeLeftExpectation = expectation(description: "Time left is less than initial value")
        
        let mockPomodoroTimer = MockPomodoroTimer()
        mockPomodoroTimer.completionHandler = {
            _ in
            if (mockPomodoroTimer.timeLeft < mockPomodoroTimer.workTime) {
                mockPomodoroTimer.timerValueDecreased = true
                timeLeftExpectation.fulfill()
            }
        }
        
        sut.pomodoroTimer = mockPomodoroTimer
        
        
        sut.startStopButtonPressed(startButton!)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertLessThan((sut.pomodoroTimer.timeLeft), sut.pomodoroTimer.workTime)
    }
    
}

extension HomeViewControllerTests {
    
    class MockPomodoroTimer: PomodoroTimer {
        
        var timerValueDecreased: Bool = false
        var completionHandler: (()->Void)?
        
        override func countDown() {
            if (timeLeft > 0) {
                timeLeft -= 1.0
                completionHandler?()
            } else {
                
                if (currentMode == PomodoroModes.Break) {
                    // If timer finishes and its a break, reset to fresh start (25)
                    timeLeft = workTime
                    timer.invalidate()
                    isActive = false
                } else {
                    // If timer finishes and its a work, reset to break depending next one is multiple of 4
                    
                    dayManager?.increaseLatestDayPomodoroCount()
                    
                    if (dayManager?.latestDay().getPomodoroCompleted() != 0 && (dayManager?.latestDay().getPomodoroCompleted())! % 4 == 0) {
                        timeLeft = longBreakTime
                    } else {
                        timeLeft = shortBreakTime
                    }
                    
                    currentMode = PomodoroModes.Break
                }
                
                
            }
        }
        
    }
    
}
