//
//  ResultsVC.swift
//  Corona
//
//  Created by Gizem Melisa Ates on 5/3/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    var message = ""
    var date = ""
    var crrdate = ""
    
    @IBOutlet weak var ResultPrompt: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultPrompt.text = message
        crrdate = date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ResultsVCtoStatsVC"){
            let statvc = segue.destination as! StatsVC
            statvc.messages = message
            statvc.date = crrdate
        }else if (segue.identifier == "ResultsVCtoMapVC"){
            let mapvc = segue.destination as! MapVC
            mapvc.data = message
            mapvc.date = crrdate
        }else if (segue.identifier == "ResultsVCtoMainVC"){
            let mainvc = segue.destination as! ViewController
            mainvc.data = message
            mainvc.date = crrdate
        }
    }
}
