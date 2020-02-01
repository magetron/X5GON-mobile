//
//  AppDelegate.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 01/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

@UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        return true
    }
}
