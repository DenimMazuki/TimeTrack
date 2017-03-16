//
//  Day.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

struct Day {
    private var pomodoroCompleted: Int
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    private var currentDate: String
    
    func getDate() -> String {
        return currentDate
    }
    
    func getPomodoroCompleted() -> String {
        return "\(pomodoroCompleted)"
    }
    
    init() {
        pomodoroCompleted = 0
        currentDate = dateFormatter.string(from: Date())
    }
}
