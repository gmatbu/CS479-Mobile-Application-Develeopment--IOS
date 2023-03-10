//
//  FoodCell.swift
//  FavFoodHw5
//
//  Created by Gizem Melisa Ates on 2/19/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
