//
//  SecondScreenViewController.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 1/29/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func nextViewButton(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "ThirdViewSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view has loaded")
    }


}
