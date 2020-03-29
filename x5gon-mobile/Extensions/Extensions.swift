//
//  Extensions.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit
import AVFoundation
import JGProgressHUD

/**
 Refresh the content and reload the view
 
 ### Usage Example: ###
 ````
  refresher(updateContent: {() -> Void in self.content.like() }, viewReload: { () -> Void in self.tableView.reloadData()})
 
 ````
 */
func refresher (updateContent: @escaping () -> Void, viewReload: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async{
        updateContent()
        DispatchQueue.main.async{
            viewReload()
        }
    }
}

func cancellableRefresher (updateContent: @escaping () -> Void, viewReload: @escaping () -> Void) {
    MainController.Queue.addOperation {
        updateContent()
        DispatchQueue.main.async{
            viewReload()
        }
    }
}

func refresherWithLoadingHUD (updateContent: @escaping () -> Void, viewReload: @escaping () -> Void, view : UIView, cancellable: Bool) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Loading"
    hud.show(in: view)
    if cancellable {
        cancellableRefresher(updateContent: updateContent, viewReload: {
            viewReload()
            hud.dismiss()
        })
    } else {
        refresher(updateContent: updateContent, viewReload: {
            viewReload()
            hud.dismiss()
        })
    }
}

extension AVAsset {
    /**
    Generate Thumbnail for `Content`
    
    ### Usage Example: ###
    ````
     AVAsset(url: contentLink).generateThumbnail { [weak self] (image, duration) in
         guard let image = image, let duration = duration else {
             return
         }
         self?.thumbnail = image
         self?.duration = duration
     }
    
    ````
    */
    func generateInformation(completion: @escaping (UIImage?, Int?, AVPlayerItem?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let playerItem = AVPlayerItem(asset: self)
            let time = CMTime(seconds: 60.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            let duration = Int(self.duration.seconds)
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image), duration, playerItem)
                } else {
                    completion(nil, nil, nil)
                }
            })
        }
    }
}

extension UIView {
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
}


extension UIColor{
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
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

extension MutableCollection where Index == Int {
    ///Implementation of Knuth Shuffle
    mutating func myShuffle() {
        if count < 2 { return }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}

extension Int {
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
            if  (minutes <= 9 && minutes >= 0) {
                ms = "0\(minutes)"
            } else{
                ms = String(minutes)
            }
            return ms
        }()
        
        let secondsString: String = {
            var ss = ""
            if  (second <= 9 && second >= 0) {
                ss = "0\(second)"
            } else{
                ss = String(second)
            }
            return ss
        }()
        
        var label = ""
        if hours == 0 {
            label =  minutesString + ":" + secondsString
        } else{
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


