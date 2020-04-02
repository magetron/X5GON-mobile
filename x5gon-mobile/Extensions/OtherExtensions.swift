//
//  Extensions.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /**
     Covert rgb number into swift `UIColor`
     - returns: UIColor
     - Parameters:
        - r: Red
        - g:  Green
        - b: Blue

     ### Usage Example: ###
     ````
     let color = rbg(233,232,101)

     ````
     */
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
        return color
    }
}

extension MutableCollection where Index == Int {
    /// Implementation of Knuth Shuffle
    mutating func myShuffle() {
        if count < 2 { return }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swapAt(i, j)
            }
        }
    }
}

extension Int {
    /// Make seconds to format string
    func secondsToFormattedString() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let second = (self % 3600) % 60
        let hoursString: String = {
            let hs = String(hours)
            return hs
        }()

        let minutesString: String = {
            var ms = ""
            if minutes <= 9, minutes >= 0 {
                ms = "0\(minutes)"
            } else {
                ms = String(minutes)
            }
            return ms
        }()

        let secondsString: String = {
            var ss = ""
            if second <= 9, second >= 0 {
                ss = "0\(second)"
            } else {
                ss = String(second)
            }
            return ss
        }()

        var label = ""
        if hours == 0 {
            label = minutesString + ":" + secondsString
        } else {
            label = hoursString + ":" + minutesString + ":" + secondsString
        }
        return label
    }
}

enum stateOfViewController {
    /// Minimise `playerView`
    case minimized
    /// Full Screen Mode
    case fullScreen
    /// Hide `playerView`
    case hidden
}

enum Direction {
    /// Moving up
    case up
    /// Moving left
    case left
    /// No movement
    case none
}
