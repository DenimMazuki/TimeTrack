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
    
    func test_StartButton_IfClickedOnce_BeginsCountingDownTimer() {
        
        sut.startStopButtonPressed(startButton!)
    }
    
}

extension HomeViewControllerTests {
    
    class MockHomeViewController: HomeViewController {
        
        
        var completionHandler: (()->Void)?
        
        override func presentInputVC() {
            completionHandler?()
        }
        
    }
    
}
