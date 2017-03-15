//
//  HomeViewController.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pomodoroLabel: UILabel!
    
    let taskManager = TaskManager()
    
    let dataProvider = TaskDataProvider()
    
    // To implement dragging of tableView to add new Task, refreshControl is overwriten
    lazy var dragToAddControl: UIRefreshControl = {
        let dragToAddControl = UIRefreshControl()
        
        dragToAddControl.addTarget(self, action: #selector(HomeViewController.presentInputVC), for: UIControlEvents.valueChanged)
        
        return dragToAddControl
    }()
    
    func presentInputVC() {
        print("HEY")
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController {
            
            nextViewController.taskManager = taskManager
            
            present(nextViewController, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        
        self.tableView.addSubview(dragToAddControl)
    }

    
    
}
