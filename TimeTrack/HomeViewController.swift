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
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
    }

}
