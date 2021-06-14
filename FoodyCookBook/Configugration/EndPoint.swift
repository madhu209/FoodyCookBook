//
//  EndPoint.swift
// FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 02/07/20.
//  Copyright © 2020 Madhusudhan Reddy. All rights reserved.
//

import Foundation

@objc internal final class Endpoint: NSObject {

    static var staticEndpoint: String {
        
        if isDebug  { return "https://www.themealdb.com/api/json/v1/1/" }
        else { return "https://www.themealdb.com/api/json/v1/1/" }
    }
    
    static var isDebug: Bool {

        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
