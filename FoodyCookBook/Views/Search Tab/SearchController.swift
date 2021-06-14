//
//  SearchController.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

/**
 The purpose of the `SearchController` is to display the Food items when user searching for food items using UITableView
 
 There's a matching scene in the *main.storyboard* file, and in that scene there is a `UITableView` with `UiTableViewcell for Food image, UILabel for Food item and category name` design. Go to Interface Builder for details.
 
 The `SearchController` class is a subclass of the `UIViewController`,

 */

class SearchController: UIViewController {

    @IBOutlet weak var searchBarObj: UISearchBar!
    @IBOutlet weak var dishListTV: UITableView!
    
    var searchResultsArray = [FoodList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        registerNib()
        searchFoodItems()
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

extension SearchController {
    
    /// To register the cell for TableView
    func registerNib() {
        dishListTV.register(FoodListTVCell.nib, forCellReuseIdentifier: FoodListTVCell.reuseID)
    }
    
    /// Call api
    func searchFoodItems() {
        
        ServiceSession.shared.callToGetDataFromServer(appendUrlString: SearchEndPoints.randomFoods + searchBarObj.text!) { jsonOutput in
                        
            let payloadjsonData = ServiceSession.shared.convertJsonDictionaryToBinaryData(jsonDict: jsonOutput as? NSDictionary ?? NSDictionary())
                        
            do {
                
                let foodList = try JSONDecoder().decode(Array<FoodList>.self, from: payloadjsonData)
                self.searchResultsArray = foodList
                self.dishListTV.reloadData()
                
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
}

// MARK: TableView Datasource and delegate methods
extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodListTVCell = tableView.dequeueReusableCell(for: indexPath)
        cell.foodListObj = searchResultsArray[indexPath.row]
        return cell
    }
    
}

// MARK: SearchBar delegate methods
extension SearchController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsArray.removeAll()
        dishListTV.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFoodItems()
        self.view.endEditing(true)
    }
        
}

// MARK: Scrollview delegate methods
extension SearchController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
