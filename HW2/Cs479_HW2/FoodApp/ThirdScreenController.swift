//
//  ThirdScreenController.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 1/29/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class ThirdScreenViewController: UIViewController {

    @IBAction func nextViewButton(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "BackHomeSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view has loaded")
    }


}
