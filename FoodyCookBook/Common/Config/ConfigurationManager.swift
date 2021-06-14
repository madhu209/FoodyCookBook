//
//  ConfigurationManager.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import Foundation

@objc internal final class ConfigurationManager: NSObject {

    // MARK: Build configuration

    static var isDebug: Bool {

        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
