//
//  UIViewExtensions.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

extension UITableView {
    /// Reload data with animation
    func reloadDataWithAnimation() {
        UIView.transition(with: self, duration: 0.6, options: .transitionCrossDissolve, animations: { self.reloadData() }, completion: nil)
    }
}

extension UIView {
    /// Make the UI view corner round
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    /// Ripple Effect
    func ripple() {
        let ripple = CATransition()
        ripple.type = .init(rawValue: "rippleEffect")
        ripple.duration = 0.5
        layer.add(ripple, forKey: nil)
    }

    /**
     Remove all `subViews` from `superView`

     ### Usage Example: ###
     ````
      self.UIView.clearSubViews()

     ````
     */
    func clearSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
