//
//  TableViewController.swift
//  hw9
//
//  Created by Gizem Melisa Ates on 3/25/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    var foodItems = ["Pizza", "Spaghetti", "Ice Cream"]
    var foodImages = ["pizza.png", "spaghetti.png", "icecream.png"]
    var text: String?
    
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "FavToAdd", sender: self)
    
    }
    
    
    @IBAction func unwindFromAddFoodViewusingSave (sender: UIStoryboardSegue)
    {
        print("the food items are \(foodItems)")
        if (text!.count > 0)
        {
            foodItems.append(text ?? "")
            foodImages.append("newFood.png")
            print("the food items are \(foodItems)")
            tableView.reloadData()
        }
    }
    
    @IBAction func unwingSegueusingCancel(sender: UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 58
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell

        // Configure the cell...
        let indexRow = indexPath.row
        cell.foodNameLabel.text = foodItems[indexRow]
        cell.foodImageView.image = UIImage(named: foodImages[indexRow])

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
            let row = indexPath.row
            foodItems.remove(at: row)
            foodImages.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let FoodName = foodItems[row]
        performSegue(withIdentifier: "FavToNear", sender: FoodName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavToNear"{
            if let destination = segue.destination as? NearbyVC{
                destination.foodName = sender as? String
            }
        }
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
