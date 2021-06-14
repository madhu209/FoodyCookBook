//
//  FoodListTVCell.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//

import UIKit

class FoodListTVCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var mealNameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var foodListObj: FoodList? {
        
        didSet {
            
            foodImageView.loadImageUsingCacheUrlString(urlString: foodListObj?.strMealThumb ?? "")
            mealNameLbl.text = foodListObj?.strMeal ?? "- -"
            categoryLbl.text = foodListObj?.strCategory ?? "- -"
            
        }
        
    }
    
}
