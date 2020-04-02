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
    /// This is a `UIWindow` The backdrop for your app’s user interface and the object that dispatches events to your views.
    var window: UIWindow?

    /**
     Tells the delegate that the launch process is almost done and the app is almost ready to run.

     - Parameters:
        - application: The singleton app object.
        - launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see Launch Options Keys.
     - returns:
      Return will be false if the app cannot handle the URL resource or continue a user activity, otherwise return true. The return value is ignored if the app is launched as a result of a remote notification.

     */
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        return true
    }

    /// Tells the delegate that the app is now in the background.
    func applicationDidEnterBackground(_: UIApplication) {
        MainController.saveUserData()
    }
}
