//
//  AddViewController.swift
//  FavFoodHw5
//
//  Created by Gizem Melisa Ates on 3/25/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
  
    @IBOutlet weak var theText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddFtoFavF") {
            let mainVC = segue.destination as? MainTableViewController
            mainVC?.text = theText.text
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
