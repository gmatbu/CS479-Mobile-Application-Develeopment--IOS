//
//  ViewController.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 1/22/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, MyTimerDelegate{
    
    let initialTime = 5
    var myTimer: MyTimer?
    // Interface outlets
    @IBOutlet weak var initialTimeLabel: UILabel!
    @IBOutlet weak var initialTimeSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Interface actions
    @IBAction func initialTimeSliderValueChanged(_ sender: UISlider) {
        let initTime = Int(sender.value)
        myTimer?.currentTime = initTime
        initialTimeLabel.text = "Delay: \(initTime)s"
        myTimer?.setInitialTime(initTime)
        
        
    }
    
    //@IBAction func nextViewButton(_ sender: //Any) {
       //print("button pressed")
       //self.performSegue(withIdentifier: //"SecondScreenViewSegue", sender: self)
           
       //}
    
    
    @IBAction func startTapped(_ sender: UIButton) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        myTimer?.start()
        //if myTimer?.currentTime == 0{
          //  nextViewButton(myTimer?.currentTime)
        //}//resetButton.isEnabled = false
        //if myTimer?.currentTime == 0{
        //    print("button pressed")
          //  self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
        //}
        //}
    }
    @IBAction func stopTapped(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        myTimer?.stop()
    }
    @IBAction func resetTapped(_ sender: UIButton) {
        // todo
    }
    
    
    func timeChanged(time: Int) {
        //
    }
    
    func timesUp() {
        //
    }
    
    
   // @IBAction func nextViewButton(_ sender: Any) {
      //  print("button pressed")
     //   self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    //}
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view has loaded")
        myTimer = MyTimer()
        myTimer?.delegate = self
        myTimer?.setInitialTime(initialTime)
        initialTimeLabel.text = "Delay: \(initialTime)s"
        
    }


}

