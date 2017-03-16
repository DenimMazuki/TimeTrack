//
//  HomeViewController.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

enum TimerState: String {
    case Start
    case Stop
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pomodoroLabel: UILabel!
    
    
    let taskManager = TaskManager()
    let dayManager = DayManager()
    let dataProvider = TaskDataProvider()
    let pomodoroTimer = PomodoroTimer()
    
    var timeLeft: Double? = 25.0 {
        didSet {
            // Casting to mute error
            if (Double(timeLeft!) > Double(pomodoroTimer.timeLeft)) {
                timeLeft = pomodoroTimer.timeLeft
                timerLabel.text = "\(timeLeft)"
            }
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // To implement dragging of tableView to add new Task, refreshControl is overwriten
    lazy var dragToAddControl: UIRefreshControl = {
        let dragToAddControl = UIRefreshControl()
        
        dragToAddControl.addTarget(self, action: #selector(HomeViewController.presentInputVC), for: UIControlEvents.valueChanged)
        
        return dragToAddControl
    }()
    
    func presentInputVC() {
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController {
            
            nextViewController.taskManager = taskManager
            
            present(nextViewController, animated: true, completion: nil)
            
        }
    }
    
    func increaseLatestDayPomodoro() {
        dayManager.increaseLatestDayPomodoroCount()
        
        pomodoroLabel.text = "\(dayManager.latestDay().getPomodoroCompleted())"
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        
        if (startButton.currentTitle == "Start") {
            startButton.setTitle("Stop", for: .normal)
        } else {
            startButton.setTitle("Start", for: .normal)
        }
        
        pomodoroTimer.initTimer()
    }
    
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        
        self.tableView.addSubview(dragToAddControl)
        
        // Check to see if current Day is already in DayManager
        if (dayManager.latestDay().getDate() != dateFormatter.string(from: Date())) {
            dayManager.addNewDay()
        }
        
        pomodoroLabel.text = "\(dayManager.latestDay().getPomodoroCompleted())"
        
    }

    
    
}
