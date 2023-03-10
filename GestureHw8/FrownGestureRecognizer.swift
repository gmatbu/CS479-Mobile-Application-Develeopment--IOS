//
//  FrownGestureRecognizer.swift
//  GestureHw8
//
//  Created by Gizem Melisa Ates on 3/11/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class FrownGestureRecognizer: MyGestureRecognizer {
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        
        print("frown: touchesBegan")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            initialPoint = point
            previousPoint = point
            state = .began
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesMoved")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            if DidDirectionChange == false {
                if(point.y <= previousPoint.y) {
                    previousPoint = point
                    state = .changed
                }
                else{
                    DidDirectionChange = true
                    state = .changed
                    }
            }
            else {
                if (point.y >= previousPoint.y) {
                    previousPoint = point
                    state = .changed
                }
                else{
                    state = .failed
                }
            }
        
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesEnded")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            let d = distance(point, initialPoint)
            //if (point != initialPoint) {
            if (d > 100.0){
                state = .ended
                print("frown: touchesEnded222")
            }
            else {
                state = .failed
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("frown: touchesCancelled")
        state = .cancelled
        
    }
    
    override func reset() {
        print("frown: reset")
        DidDirectionChange = false
        
    }
    
   
    
    

}
