//
//  CustomTimer.swift
//  TimeTrack
//
//  Created by Denim Mazuki on 3/15/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

class CustomTimer: NSObject {
    private var timer: Timer = Timer()
    private var state: Bool = true
    var timeLeft: Double = 25.0
    
    func initTimer() {
        // Start timer
        if (self.state) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                _ in self.countDown()
                
            }
        } else {
            timeLeft = 25.0
            timer.invalidate()
        }
        
        self.state = !self.state
    }
    
    @objc func countDown() {
        timeLeft -= 1.0
        print(timeLeft)
    }
    
}
