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
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        sut = viewController as! HomeViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HomeVC_ContainsTableViewAfterViewDidLoad() {
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource is TaskDataProvider)
    }
    
    
    
}
