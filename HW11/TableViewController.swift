//
//  TableViewController.swift
//  HW11
//
//  Created by Gizem Melisa Ates on 4/15/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let names = ["Pizza", "Spaghetti", "Ice Cream", "Tacos", "Salad"]
        let name = names.randomElement()
        let calories = Int.random(in: 100...500)
        var image: String!
        
        if name == "Pizza"{
            image = "pizza.png"
        }
        else if name == "Spaghetti"{
            image = "spaghetti.png"
        }
        else if name == "Tacos"{
            image = "tacos.jpg"
        }
        else if name == "Salad"{
            image = "salad.jpg"
        }
        else{
            image = "icecream.jpg"
        }
        
        let food = addFood(name: name!, calories: calories, imageFileName: image)
        foodObjs.append(food)
        tableView.reloadData()
    }
    
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var foodObjs: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        foodObjs = getFood()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodObjs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

        // Configure the cell...
        
        let row = indexPath.row
        let food = foodObjs[row]
        cell.textLabel?.text = food.value(forKey: "name") as? String
        let calories = food.value(forKey: "calories") as? Int
        cell.detailTextLabel?.text = "\(calories!) cals"
        let imageFileName = food.value(forKey: "imageFileName") as? String
        cell.imageView?.image = UIImage(named: imageFileName!)

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
            let food = foodObjs[row]
            foodObjs.remove(at: row)
            removeFood(food)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    
    func addFood(name: String, calories: Int, imageFileName: String) -> NSManagedObject {
        let food = NSEntityDescription.insertNewObject(forEntityName:
            "FoodItem", into: self.managedObjectContext)
        food.setValue(name, forKey: "name")
        food.setValue(calories, forKey: "calories")
        food.setValue(imageFileName, forKey: "imageFileName")
        appDelegate.saveContext() // In AppDelegate.swift
        return food
        
    }
    
    func getFood() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodItem")
        var foods: [NSManagedObject] = []
        do {
            foods = try self.managedObjectContext.fetch(fetchRequest)
            
        } catch {
            print("getFood error: \(error)") }
            return foods
    }
    
    func removeFood(_ player: NSManagedObject) {
        managedObjectContext.delete(player)
        appDelegate.saveContext()
    }


}
