//
//  ViewController.swift
//  Corona
//
//  Created by Gizem Melisa Ates on 5/2/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data = ""
    var date = ""
    let defaults = UserDefaults.standard

    @IBOutlet weak var pastResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (data != "" && date != ""){
            pastResult.text = "Last test result from \"\(date)\" is \n-->\(data)"
            pastResult.isHidden = false
        }else{
            pastResult.isHidden = true
        }
    }
}
