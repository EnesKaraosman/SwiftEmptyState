//
//  ViewController.swift
//  SwiftEmptyState
//
//  Created by eneskaraosman on 02/18/2020.
//  Copyright (c) 2020 eneskaraosman. All rights reserved.
//

import UIKit

class HostController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionVC = UINavigationController(
            rootViewController: CollectionViewController(
                collectionViewLayout: UICollectionViewFlowLayout()
            )
        )
        collectionVC.tabBarItem = UITabBarItem(title: "CollectionView", image: #imageLiteral(resourceName: "grid_view"), selectedImage: #imageLiteral(resourceName: "grid_view_selected"))
        
        let tableVC = UINavigationController(rootViewController: TableViewController())
        tableVC.tabBarItem = UITabBarItem(title: "TableView", image: #imageLiteral(resourceName: "table_view"), selectedImage: #imageLiteral(resourceName: "table_view_selected"))
        
        setViewControllers([collectionVC, tableVC], animated: true)
        
    }

}

