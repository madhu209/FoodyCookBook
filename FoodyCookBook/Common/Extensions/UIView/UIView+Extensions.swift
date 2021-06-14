//
//  UIView+Extensions.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

protocol Reusable {}

extension UIView: Reusable {}

extension Reusable where Self: UIView {
    
    static var reuseID: String {
        return String(describing: self)
    }

    // FIXME: The code below is not related to `Reusable` protocol. Consider moving it to another place

    static var nib: UINib {
        let nibName = String(describing: self)

        return UINib(nibName: nibName, bundle: nil)
    }

    static var brandedNibName: String {
        return "" + String(describing: self) // In Empty we need to TargetName
    }

//    static var brandedNib: UINib {
//        return UINib(nibName: brandedNibName, bundle: nil)
//    }

    static func instantiateFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            preconditionFailure("The nib \(nib) expected its root view to be of type \(self)")
        }

        return view
    }

//    static func instantiateFromBrandedNib() -> Self {
//        guard let view = brandedNib.instantiate(withOwner: nil, options: nil).first as? Self else {
//            preconditionFailure("The nib \(brandedNib) expected its root view to be of type \(self)")
//        }
//
//        return view
//    }

    static func transitionCrossDissolve<T: UIView>(_ view: T,
                                                   duration: TimeInterval = 0.25,
                                                   animations: @escaping (T) -> Void) {
        if duration > 0 && view.window != nil {
            UIView.transition(with: view,
                              duration: duration,
                              options: [.transitionCrossDissolve,
                                        .allowUserInteraction],
                              animations: { animations(view) })

        } else {
            animations(view)
        }
    }
    
    func applyCornerRadius(_ tempView : UIView) {
        tempView.cornerRadius = tempView.frame.size.height/2
    }
}

extension UIView {
//    class func fromNib<T: UIView>() -> T {
//        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
//    }
}

extension UIView {
    enum LegacyUserInterfaceStyle {
        case light, dark
    }

    var legacyUserInterfaceStyle: LegacyUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark: return .dark
            default: return .light
            }

        } else {
            return .light
        }
    }
}
