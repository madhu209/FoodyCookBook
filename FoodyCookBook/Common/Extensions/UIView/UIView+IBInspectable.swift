//
//  UIView+IBInspectable.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Borders

    /// Corner radius of the view.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// Border width of the view.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let layerBorderColor = layer.borderColor {
                return UIColor(cgColor: layerBorderColor)

            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Shadows

    /// Shadow radius of the view.
    /// - Note: if property `clipsToBounds` is set to `true`, this parameter has no effect.
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// Shadow color of the view.
    /// - Note: if property `clipsToBounds` is set to `true`, this parameter has no effect.
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let layerShadowColor = layer.shadowColor {
                return UIColor(cgColor: layerShadowColor)

            } else {
                return nil
            }
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// Shadow opacity of the view.
    /// - Note: if property `clipsToBounds` is set to `true`, this parameter has no effect.
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// Shadow offset of the view.
    /// - Note: if property `clipsToBounds` is set to `true`, this parameter has no effect.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}
