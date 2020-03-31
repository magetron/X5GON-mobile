//
//  UIViewExtensions.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


extension UITableView {
    func reloadDataWithAnimation() {
        UIView.transition(with: self, duration: 0.6, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func ripple(){
        let ripple = CATransition()
        ripple.type = .init(rawValue: "rippleEffect")
        ripple.duration = 0.5
        self.layer.add(ripple, forKey: nil)
    }
    
    /**
    Remove all `subViews` from `superView`
    
    ### Usage Example: ###
    ````
     self.UIView.clearSubViews()
    
    ````
    */
    func clearSubViews () {
        self.subviews.forEach({ $0.removeFromSuperview() })
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
