//
//  ViewController.swift
//  FoodApp
//

import UIKit

class ViewController: UIViewController {
    
    var FoodItemLabel: String?
    var foodIndex = 0
    var foodNames = ["Pizza!", "Spaghetti!", "Ice Cream"]
    var imageNames = ["pizza.png", "spaghetti.png", "icecream.png"]
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        foodIndex = (foodIndex + 1) % foodNames.count
        updateFood()
    }
    
    func updateFood() {
        headingLabel.text = "My #\(foodIndex+1) favorite food is..."
        foodLabel.text = foodNames[foodIndex]
        foodImageView.image = UIImage(named: imageNames[foodIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddFoodSegue") {
            let secondVC = segue.destination as! AddFoodViewController
            secondVC.textfromMain = foodNames.count + 1
        }
    }
    
    @IBAction func unwindFromAddFoodViewusingCancel (sender: UIStoryboardSegue)
    {
    }
    
    @IBAction func unwindFromAddFoodViewusingSave (sender: UIStoryboardSegue)
    {
        if (FoodItemLabel!.count > 0)
        {
            foodNames.append(FoodItemLabel ?? "")
            imageNames.append("food.png")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foodIndex = 0
        updateFood()
    }
    


}

