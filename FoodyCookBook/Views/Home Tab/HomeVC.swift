//
//  ViewController.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

/**
 The purpose of the `HomeVC` is to display the Random Food items
 
 There's a matching scene in the *main.storyboard* file, and in that scene there is a `UITableView` with `UiTableViewcell for Food image, UILabel for Food item and category name` design. Go to Interface Builder for details.
 
 The `HomeVC` class is a subclass of the `UIViewController`,

 */

class HomeVC: UIViewController {

    @IBOutlet weak var dishListTV: UITableView!
    
    var foodListArray = [FoodList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerNib()
        getRandomFoodItems()
        
    }

}


extension HomeVC {
    
    func registerNib() {
        dishListTV.register(FoodListTVCell.nib, forCellReuseIdentifier: FoodListTVCell.reuseID)
    }
    
    func getRandomFoodItems() {
        
        ServiceSession.shared.callToGetDataFromServer(appendUrlString: HomeEndPoints.randomFoods) { jsonOutput in
                        
            let payloadjsonData = ServiceSession.shared.convertJsonDictionaryToBinaryData(jsonDict: jsonOutput as? NSDictionary ?? NSDictionary())
                        
            do {
                
                let foodList = try JSONDecoder().decode(Array<FoodList>.self, from: payloadjsonData)
                self.foodListArray = foodList
                self.dishListTV.reloadData()
                
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodListTVCell = tableView.dequeueReusableCell(for: indexPath)
        cell.foodListObj = foodListArray[indexPath.row]
        return cell
    }
    
}
