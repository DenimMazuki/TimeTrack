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
    
    func pomodoroCompleted(on day: Day) -> Int {
        
        let selectedDay = days.filter {
            (foundDay) in
            
            foundDay.getDate() == day.getDate()
        }
        
        return (selectedDay.first?.getPomodoroCompleted())!
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
    
    func removeAll() {
        days.removeAll()
    }
    
    func increaseLatestDayPomodoroCount() {
        days[days.count - 1].increasePomodoro()
    }
}
