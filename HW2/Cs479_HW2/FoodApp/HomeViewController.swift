//
//  ViewController.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 1/22/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func addViewButton(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view has loaded")
    }


}

