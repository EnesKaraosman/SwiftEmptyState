//
//  ViewController.swift
//  SwiftEmptyState
//
//  Created by eneskaraosman on 02/18/2020.
//  Copyright (c) 2020 eneskaraosman. All rights reserved.
//

import UIKit

extension UIViewController {
    func embedInNavigationViewController() -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: self)
        return navCtrl
    }
}

class HostController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionVC = CollectionViewController(
            collectionViewLayout: UICollectionViewFlowLayout()
        ).embedInNavigationViewController()
        collectionVC.tabBarItem = UITabBarItem(title: "CollectionView", image: #imageLiteral(resourceName: "grid_view"), selectedImage: #imageLiteral(resourceName: "grid_view_selected"))
        
        let tableVC = TableViewController().embedInNavigationViewController()
        tableVC.tabBarItem = UITabBarItem(title: "TableView", image: #imageLiteral(resourceName: "table_view"), selectedImage: #imageLiteral(resourceName: "table_view_selected"))
        
        let vc = ViewController().embedInNavigationViewController()
        vc.tabBarItem = UITabBarItem(title: "UIView", image: #imageLiteral(resourceName: "f1_car"), selectedImage: #imageLiteral(resourceName: "f1_car_selected"))
        
        setViewControllers([collectionVC, tableVC, vc], animated: true)
        
    }

}
