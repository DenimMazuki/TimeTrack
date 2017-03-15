//
//  InputViewControllerTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_BackButton_DismissesInputVC() {
        
        let mockViewController = MockInputViewController()
        
        mockViewController.backButtonPressed()
        
        XCTAssertTrue(mockViewController.dismissGotCalled)
        
    }
    
    
}

extension InputViewControllerTests {
    
    class MockInputViewController: InputViewController {
        
        var dismissGotCalled = false
        var completionHandler: (()->Void)?
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissGotCalled = true
            completionHandler?()
        }
        
        
    }
    
}
