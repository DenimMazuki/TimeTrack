//
//  TaskCellTests.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import TimeTrack


class TaskCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: TaskCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "TaskCell", for: IndexPath(row: 0, section: 0)) as! TaskCell
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_CellContainsTitleLabel() {
        
        XCTAssertNotNil(cell.titleLabel)
    }
    
}

extension TaskCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            return UITableViewCell()
        }
        
    }
    
}
