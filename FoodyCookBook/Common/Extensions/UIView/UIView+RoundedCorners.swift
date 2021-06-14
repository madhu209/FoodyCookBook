//
//  UIView+RoundedCorners.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
    }

    @available(iOS 11.0, *)
    func roundCorners(maskedCorners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
}
