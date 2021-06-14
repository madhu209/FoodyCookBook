//
//  UITableView+Dequeue.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Cannot dequeue reusable cell with identifier \(T.reuseID)")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("Cannot dequeue reusable HeaderFooter with identifier \(T.reuseID)")
        }

        return headerFooter
    }
    
    func showIndicatorForPaginationTableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.row < 8 {
            if let footer = tableView.tableFooterView {
                footer.isHidden = true
            }
            return
        }
        
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
        
    }
    
}
