//
//  AddFoodViewController.swift
//  FoodApp
//
//  Created by Gizem Melisa Ates on 2/12/20.
//  Copyright © 2020 Larry Holder. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController, UITextFieldDelegate {
    var textfromMain: Int = 0
    
    @IBOutlet weak var nameoffood: UILabel!
    
    @IBOutlet weak var InputLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        InputLabel.delegate = self
        // Do any additional setup after loading the view.
        nameoffood.text = "Enter name of food #\(textfromMain)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "UnwindusingSave") {
    
            let mainV = segue.destination as! ViewController
            mainV.FoodItemLabel = InputLabel.text
        }
    }

}
