//
//  CustomTimer.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

enum PomodoroCases {
    case Work
    case Break
}

class PomodoroTimer: NSObject {
    private var timer: Timer = Timer()
    private var isActive: Bool = true
    var timeLeft: Double = 25.0
    private var currentCase = PomodoroCases.Break
    
    func initTimer() {
        // If current case is on break, starting timer will set it to work
        
        if (!isActive) {
            
            isActive = true
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                _ in self.countDown()
                
            }
        } else {
            timeLeft = 25.0
            // If already active: depends on two case
            if (currentCase == PomodoroCases.Break) {
                currentCase = PomodoroCases.Work
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                    _ in self.countDown()
                    
                }
            } else {
                
                isActive = false
                currentCase = PomodoroCases.Break
            }
            
            
        }

    }
    
    @objc func countDown() {
        
        
        
        if (timeLeft > 0) {
            timeLeft -= 1.0
        } else {
            
            if (currentCase == PomodoroCases.Break) {
                // If timer finishes and its a break, reset to fresh start (25)
                timeLeft = 25.0
            } else {
                // If timer finishes and its a work, reset to break (5)
                timeLeft = 5.0
            }
            
            timer.invalidate()
            isActive = false
            
        }
        
    }
    
}
