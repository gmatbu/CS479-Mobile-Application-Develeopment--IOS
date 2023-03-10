//
//  FoodCell.swift
//  hw9
//
//  Created by Gizem Melisa Ates on 3/25/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    
    
    @IBOutlet weak var FoodImageView: UIImageView!
    
    @IBOutlet weak var FoodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
