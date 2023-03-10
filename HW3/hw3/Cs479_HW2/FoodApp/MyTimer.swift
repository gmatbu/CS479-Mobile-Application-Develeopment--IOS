//
//  MyTimer.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 2/5/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//
import UIKit
import Foundation


protocol MyTimerDelegate {
    func timeChanged (time: Int)
    func timesUp ()
}


class MyTimer {
    var delegate: MyTimerDelegate?;
    var initialTime: Int = 5
    var currentTime: Int = 5
    
    var timer: Timer?
    func start() {
    // Start immediately
    timer = Timer.scheduledTimer(withTimeInterval: 1.0,
           repeats: true, block: handleTick)

        
    }
    
    
    
    func stop() {
        timer?.invalidate()
    }
    func handleTick (timer:Timer) {
        if currentTime > 0{
            currentTime = currentTime - 1
            print("cur - 1")
            if (currentTime == 0){
                currentTime =
                delegate?.timesUp()
            }
        }
    }
    
    
    func reset(){
        if currentTime != initialTime{
            currentTime = initialTime
            delegate?.timeChanged(time: currentTime)
        }
    }
    func setInitialTime(_ initTime: Int) {
        initialTime = initTime
    }
}
