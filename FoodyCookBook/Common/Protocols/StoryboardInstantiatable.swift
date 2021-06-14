//
//  StoryboardInstantiatable.swift
// FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 19/06/20.
//  Copyright © 2020 Madhusudhan Reddy. All rights reserved.
//

import UIKit

internal protocol StoryboardInstantiatable where Self: UIViewController {
    static var instantiatedAsRootViewControllerOfNavigationController: Bool { get }

    static var hostingStoryboard: UIStoryboard { get }
    static var identifierInHostingStoryboard: String? { get }
}

// MARK: - Instantiate From Storyboard
extension StoryboardInstantiatable {
    static var instantiatedAsRootViewControllerOfNavigationController: Bool { false }

    static func instantiateFromStoryboard() -> Self {
        let result: UIViewController?

        if let nonnullIdentifier = self.identifierInHostingStoryboard {
            result = self.hostingStoryboard.instantiateViewController(withIdentifier: nonnullIdentifier)

        } else {
            result = self.hostingStoryboard.instantiateInitialViewController()
        }

        let resultingController: Self?

        if instantiatedAsRootViewControllerOfNavigationController {
            resultingController = (result as? UINavigationController)?.viewControllers.first as? Self

        } else {
            resultingController = result as? Self
        }

        if let resultingController = resultingController {
            return resultingController

        } else {
            fatalError("Failed to instantiate \(Self.self) from \(self.hostingStoryboard)")
        }
    }
}
