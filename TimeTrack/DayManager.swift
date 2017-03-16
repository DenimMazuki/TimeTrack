//
//  DayManager.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

class DayManager {
    
    private var days : [Day] = []
    
    func addNewDay() {
        days.append(Day())
    }
    
    func pomodoroCompleted(on: Day) -> Int {
        
        return 0
    }
    
    func latestDay() -> Day {
        if (days.isEmpty) {
            days.append(Day())
        }
        
        return days[days.count -  1]
    }
    
    func numberOfDays() -> Int {
        return days.count
    }
    
}
