//
//  Refresher.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 30/03/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

/**
 Refresh the content and reload the view
 
 ### Usage Example: ###
 ````
  refresher(updateContent: {() -> Void in self.content.like() }, viewReload: { () -> Void in self.tableView.reloadDataWithAnimation()})
 
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
