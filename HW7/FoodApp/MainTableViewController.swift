//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var foodItems = [FoodItem]()
    

    @IBAction func addFoodItemTapped(_ sender: UIBarButtonItem) {
        let foodItem = FoodItem(name: "Food", imageFileName: "food.png", caloriesPerServing: 100)
        foodItems.append(foodItem)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = 58
        initializeFoodItems()
    }
    
    func initializeFoodItems() {
        var foodItem = FoodItem(name: "Pizza", imageFileName: "pizza.png", caloriesPerServing: 300)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Spaghetti", imageFileName: "spaghetti.png", caloriesPerServing: 200)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Ice Cream", imageFileName: "icecream.png", caloriesPerServing: 500)
        foodItems.append(foodItem)
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell

        // Configure the cell...
        let foodItem = foodItems[indexPath.row]
        cell.foodImageView?.image = UIImage(named: foodItem.imageFileName)
        cell.foodNameLabel?.text = foodItem.name
        cell.caloriesLabel?.text = "\(foodItem.caloriesPerServing) cals"

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            foodItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    func handleNotification(response: UNNotificationResponse){
        
        for question in self.foodItems{
            
            if (response.notification.request.content.userInfo["message"] as! String) == question.id{
                //let cell = tableView.cellForRow() as! FoodCell
                
            }
        print("Invalid Unique ID");
        }
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodItem = foodItems[indexPath.row]
        let alert = UIAlertController(title: "Food Notification",
                                      message: "Do you want to schedule a notification for \(foodItem.name)?", preferredStyle: .alert)
        let goAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
               // execute some code when this option is selected
            
            let cell = tableView.cellForRow(at: indexPath) as! FoodCell
            cell.foodNameLabel?.textColor = UIColor.red
            let content = UNMutableNotificationContent()
            content.title = "Food Alert"
            content.body = "Time to eat \(foodItem.name)"
            content.userInfo["message"] = foodItem.id

            // Configure trigger for 5 seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,
                repeats: false)
                let request = UNNotificationRequest(identifier: foodItem.id,
                                 content: content, trigger: trigger)
                // Schedule request
                let center = UNUserNotificationCenter.current(); center.add(request, withCompletionHandler: { (error) in
                    if let err = error { print(err.localizedDescription)
                    } })
        print("Go!") })
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: { (action) in
        print("Cancel.") })
        
        alert.addAction(goAction)
        alert.preferredAction = goAction // only affects .alert style alert.addAction(stopAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
