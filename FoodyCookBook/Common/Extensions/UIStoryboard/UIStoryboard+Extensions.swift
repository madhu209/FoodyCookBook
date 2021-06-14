//
//  UIStoryboard+Extensions.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    private enum Name: String {
        case main = "Main"
        case tabBar = "TabBar"
    }

    static var main: UIStoryboard { return  .named(.main) }
    static var tabBar: UIStoryboard { return  .named(.tabBar) }

    // MARK: Methods

    private static func named(_ name: Name, prebranded: Bool = false) -> UIStoryboard {
        let storyboardName = name.rawValue

        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}
