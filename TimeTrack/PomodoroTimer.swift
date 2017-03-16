//
//  PomodoroTimer.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

enum PomodoroModes {
    case Work
    case Break
}

class PomodoroTimer: NSObject {
    var timer: Timer = Timer()
    var isActive: Bool = false
    var timeLeft: Double
    var currentMode = PomodoroModes.Break
    
    var breakTime = 5.0
    var workTime = 25.0
    
    func initTimer() {
        // If current case is on break, starting timer will set it to work
        
        if (currentMode == PomodoroModes.Break) {
            currentMode = PomodoroModes.Work
        }
        
        if (!isActive) {
            
            isActive = true
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                _ in self.countDown()
                
            }
        } else {
            timeLeft = workTime
            // If already active: depends on two case
            if (currentMode == PomodoroModes.Break) {
                currentMode = PomodoroModes.Work
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                    _ in self.countDown()
                    
                }
            } else {
                
                isActive = false
                currentMode = PomodoroModes.Break
            }
            
            
        }

    }
    
    @objc func countDown() {
        
        
        
        if (timeLeft > 0) {
            timeLeft -= 1.0
        } else {
            
            if (currentMode == PomodoroModes.Break) {
                // If timer finishes and its a break, reset to fresh start (25)
                timeLeft = workTime
                timer.invalidate()
                isActive = false
            } else {
                // If timer finishes and its a work, reset to break (5)
                timeLeft = breakTime
                currentMode = PomodoroModes.Break
            }
            
            
        }
        
    }
    
    override init() {
        timeLeft = workTime
        
        super.init()
    }
    
}
