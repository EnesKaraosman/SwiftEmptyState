//
//  AppDelegate.swift
//  SwiftEmptyState
//
//  Created by eneskaraosman on 02/25/2020.
//  Copyright (c) 2020 eneskaraosman. All rights reserved.
//

import UIKit
import SwiftEmptyState

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = UIViewController()
        let esv = EmptyStateView(
            messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            titleText: "Title",
            image: #imageLiteral(resourceName: "icon_404"),
            buttonText: "Button",
            completionHandler: nil
        )
        
        
        vc.view.addSubview(esv)
        esv.snp.makeConstraints { $0.edges.equalToSuperview() }
//        window?.rootViewController = vc
        
        
        window?.rootViewController = HostController()
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}
