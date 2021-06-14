//
//  UIColor+Extensions.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: r.cgFloatValue / 255.0,
                  green: g.cgFloatValue / 255.0,
                  blue: b.cgFloatValue / 255.0,
                  alpha: alpha)
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(r: rgb, g: rgb, b: rgb, alpha: alpha)
    }

    static func dynamicColor(name: String, color: UIColor) -> UIColor {
        guard #available(iOS 11.0, *) else {
            return color
        }

        return UIColor(named: name) ?? color
    }
}

extension UIColor {
                
    static var ApplicationColor: UIColor {
        UIColor.dynamicColor(name: "ApplicationColor",
                             color: UIColor(r: 240, g: 158, b: 56))
    }
        
    public class func hexCode(_ hexString: String) -> UIColor {
        
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start]) // Swift 4 //hexString.substring(from: start)
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                    a = CGFloat(1)
                    
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        
        return UIColor.black
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
}
