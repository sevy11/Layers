//
//  AppDelegate.swift
//  Layers
//
//  Created by Michael Sevy on 5/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import UIKit
import Parse
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        _ = FacebookManager.shared
        _ = FacebookManager.shared.initializeDelegate(application: application, launchOptions: launchOptions)

        let configuration = ParseClientConfiguration {
            $0.applicationId = "com.sevy.Layers"
            $0.server = "https://evening-ocean-18307.herokuapp.com/"
        }
        Parse.initialize(with: configuration)
        FIRApp.configure()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let facebookURL = FacebookManager.shared.initializeURLDelegate(application: app, url: url, options: options)
        return facebookURL
    }

    @nonobjc func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return FacebookManager.shared.initializeSourceApplicationDelegate(application: application, url: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FacebookManager.shared.activate()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

}

