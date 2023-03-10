//
//  ViewController.swift
//  GestureHw8
//
//  Created by Gizem Melisa Ates on 3/10/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    

    @IBOutlet weak var TasteLabel: UILabel!
    
    @IBOutlet weak var Smiley: UIImageView!
    
    @IBAction func IsClearTapped(_ sender: UIButton) {
        
        TasteLabel.isHidden = true;
        Smiley.isHidden = true;
        print("Clear")
        smileGestureRecognizer.clearBoxes()
        frownGestureRecognizer.clearBoxes()
        
        
        
    }
    
    var smileGestureRecognizer: SmileGestureRecognizer!
    var frownGestureRecognizer: FrownGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*let panGestureRecognizer = UIPanGestureRecognizer(target: self, action:
            #selector(handlePan))
        panGestureRecognizer.delegate = self;
        self.view.addGestureRecognizer(panGestureRecognizer)*/
        
        smileGestureRecognizer = SmileGestureRecognizer(target: self, action: #selector(handleSmile))
        frownGestureRecognizer = FrownGestureRecognizer(target: self, action: #selector(handleFrown))
        frownGestureRecognizer.delegate = self
        smileGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(smileGestureRecognizer)
        self.view.addGestureRecognizer(frownGestureRecognizer)
        
        TasteLabel.isHidden = true;
        Smiley.isHidden = true;
        
    }
    
    @objc func handleSmile(_ sender: SmileGestureRecognizer) {
        
        let point = sender.location(in: self.view)
        sender.drawBox(point)
        if sender.state == .ended {
            print("Smile detected")
            TasteLabel.text = "Tastes Good!"
            Smiley.image = UIImage(named: "TastesGood.jpg")
            TasteLabel.isHidden = false
            Smiley.isHidden = false
        }
    }
    
    @objc func handleFrown(_ sender: FrownGestureRecognizer) {
        
        let point = sender.location(in: self.view)
        sender.drawBox(point)
        if sender.state == .ended {
            print("Frown detected")
            TasteLabel.text = "Tastes Bad!"
            Smiley.image = UIImage(named: "TastesBad.jpg")
            TasteLabel.isHidden = false
            Smiley.isHidden = false
        }
    }
    /*@IBAction func IsClearTapped(_ sender: UIButton) {
        
        TasteLabel.isHidden = true;
        Smiley.isHidden = true;
        print("Clear")
        smileGestureRecognizer.clearBoxes()
        frownGestureRecognizer.clearBoxes()
        
    }*/

   /* @objc func handlePan (_ sender: UIPanGestureRecognizer) { let point = sender.location(in: self.view)
        let x = Int(point.x)
        let y = Int(point.y)
        if (sender.state == .began) {
            print("pan began at (\(x),\(y))")
        }
        if (sender.state == .changed) {
            print ("pan moved to (\(x),\(y))")
    
        }
        if (sender.state == .ended) {
            print ("pan ended at (\(x),\(y))")
        }
        
    }*/
    
    

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is SmileGestureRecognizer{
            if otherGestureRecognizer is FrownGestureRecognizer{
                return true
            }
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is SmileGestureRecognizer{
            if otherGestureRecognizer is FrownGestureRecognizer{
                return true
            }
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton{
            return false
        }
        return true
    }
    
   

}


