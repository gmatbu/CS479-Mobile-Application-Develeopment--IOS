//
//  MyGestureRecognizer.swift
//  GestureHw8
//
//  Created by Gizem Melisa Ates on 3/11/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class MyGestureRecognizer: UIGestureRecognizer {
    
    var initialPoint: CGPoint!
    var previousPoint: CGPoint!
    
    var DidDirectionChange: Bool = false
    var boxViews: [UIView] = []
    
    func distance(_ point1: CGPoint, _ point2: CGPoint) -> Double{
        
        let xdiff = point1.x - point2.x
        let ydiff = point1.y - point2.y
        return Double(sqrt(xdiff*xdiff + ydiff*ydiff))
    }
    
    func drawBox (_ point: CGPoint){
        
        let boxRectangle = CGRect(x: point.x, y: point.y, width: 5.0, height: 5.0)
        let boxView = UIView(frame: boxRectangle)
        boxView.backgroundColor = UIColor.red
        self.view?.addSubview(boxView)
        boxViews.append(boxView)
    }
    
    func clearBoxes(){
        
        for boxView in boxViews {
            boxView.removeFromSuperview()
        }
        boxViews.removeAll()
    }
    
    
}

