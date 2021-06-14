//
//  UIView+CalculateHeight.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import UIKit

extension UIView {
    @objc func estimatedHeight() -> CGFloat {
        return systemLayoutSizeFitting(CGSize(width: frame.width, height: 0),
                                       withHorizontalFittingPriority: .required,
                                       verticalFittingPriority: .fittingSizeLevel).height
    }
}
