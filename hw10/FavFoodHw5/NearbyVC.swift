//
//  NearbyVC.swift
//  FavFoodHw5
//
//  Created by Gizem Melisa Ates on 3/25/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class NearbyVC: UIViewController
{
    
    var foodName: String!
    var RecipeApi = "93cf0d2ef5344c40ad054d09ae47c0d2"
    var RecipeURLString: String!
    var baseUri = "https://spoonacular.com/recipeImages/"
   
    
    @IBOutlet weak var RecipeImageView: UIImageView!
    @IBOutlet weak var RecipeTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        RecipeURLString = "https://api.spoonacular.com/recipes/search?query=\(foodName!)&apiKey=\(self.RecipeApi)"
        //print("recipe = \(RecipeURLString)")
        getRecipe()
    
    }
    
    func getRecipe() {
        // May not know exactly what's in the URL, so replace special characters with % encoding
        if let urlStr = RecipeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url, completionHandler: handleRecipeResponse)
                dataTask.resume()
            } }
    }
    func handleRecipeResponse (data: Data?, response: URLResponse?, error: Error?) {
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
        //print("jsonObj: \(try? JSONSerialization.jsonObject(with: somedata))")
        // 5. Check for properly-formatted JSON data
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
            let jsonDict1 = jsonObj as? [String: Any],
            let articleArray = jsonDict1["results"] as? [Any], articleArray.count > 0,
            let jsonDict2 = articleArray[0] as? [String: Any],
            let titleStr = jsonDict2["title"] as? String,
            let urlToImage = jsonDict2["image"] as? String else {
                print("error: invalid JSON data")
                DispatchQueue.main.async {
                    self.RecipeTitleLabel.text = "No recipe found"
                    
                }
                return
        }
        // 6. Everything seems okay
        print("urlToImage is \(urlToImage)")
        self.loadRecipeImage(self.baseUri + urlToImage)
        DispatchQueue.main.async {
            self.RecipeTitleLabel.text = titleStr
            
        }
    }
    
    func loadRecipeImage(_ urlString: String) {
        // URL comes from API response; definitely needs some safety checks
        //print("urlString = \(urlString)")
        if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            //print("urlStr = \(urlStr)")
            if let url = URL(string: urlStr) {
                //print("url = \(url)")
                let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
                    //print("data = \(data)")
                    if let imageData = data {
                        let imageView = UIImage(data: imageData)
                        
                        DispatchQueue.main.async {
                            self.RecipeImageView.image = imageView
                            
                        }
                        
                    }
                    
                })
                dataTask.resume()
                
            }
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
