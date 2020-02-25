//
//  AppDelegate.swift
//  SwiftEmptyState
//
//  Created by eneskaraosman on 02/25/2020.
//  Copyright (c) 2020 eneskaraosman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = HostController()
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}
