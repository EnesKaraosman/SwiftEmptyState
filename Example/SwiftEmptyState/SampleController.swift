//
//  SampleController.swift
//  SwiftEmptyState_Example
//
//  Created by Enes Karaosman on 19.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

protocol SampleController where Self: UIViewController {
    
    var dataSource: [UIColor] { get set }
    func setEnableEmptyStateBarButton()
    func setDisableEmptyStateBarButton()
    
}

