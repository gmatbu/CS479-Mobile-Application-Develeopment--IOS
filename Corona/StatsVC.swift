//
//  StatsVC.swift
//  Corona
//
//  Created by Gizem Melisa Ates on 5/5/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {
    
    @IBOutlet weak var CasesLabel: UILabel!
    @IBOutlet weak var TodaysCasesLabel: UILabel!
    @IBOutlet weak var DeathsLabel: UILabel!
    @IBOutlet weak var TodaysDeaths: UILabel!
    @IBOutlet weak var ActiveLabel: UILabel!
    
    var UrlString: String?
    var messages = ""
    var crrmessage = ""
    var date = ""
    var crrdate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crrmessage = messages
        crrdate = date
        
        //https://www.tutorialspoint.com/how-add-1-day-to-date-in-swift
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let currentDate = Date()
//        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)! //the day before
        //let dateNeeded = "2020-04-05T00:00:00Z"
//
        let UrlString = "https://disease.sh/v2/states"
        
        getStat(UrlString: UrlString)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StatsVCtoResultsVC"){
            let resultsvc = segue.destination as! ResultsVC
            resultsvc.message = crrmessage
            resultsvc.date = crrdate
        }
    }
    
    func getStat(UrlString: String) {
        // May not know exactly what's in the URL, so replace special characters with % encoding
        if let urlStr = UrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url, completionHandler: handleResponse)
                dataTask.resume()
            }
        }
    }
    
    func handleResponse (data: Data?, response: URLResponse?, error: Error?) {
        // 1. Check for error in request (e.g., no network connection)
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        // 2.
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            return
        }
        let statusCode = httpResponse.statusCode
        // 3.
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        // 4.
        guard let somedata = data else {
            print("error: no data")
            return
        }
        //print("jsonObj: \(try! JSONSerialization.jsonObject(with: somedata))")
        // 5. Check for properly-formatted JSON data
        let jsonObj = try! JSONSerialization.jsonObject(with: somedata)
        let jsonDict1 = jsonObj as! [Any]
        for item in jsonDict1 {
            if let dictItem = item as? [String: Any] {
                if dictItem["state"] as! String == "Washington" {
                    DispatchQueue.main.async {
                        self.CasesLabel.text = "Cases= \(dictItem["cases"] as! Int)"
                        self.TodaysCasesLabel.text = "Today's Cases = \(dictItem["todayCases"] as! Int)"
                        self.DeathsLabel.text = "Deaths = \(dictItem["deaths"] as! Int)"
                        self.TodaysDeaths.text = "Today's Deaths= \(dictItem["todayDeaths"]as!Int)"
                        self.ActiveLabel.text = "Active = \(dictItem["active"] as! Int)"
                    }
                }
            }else{
                print("error: invalid JSON data")
            }
        }
    }
}
