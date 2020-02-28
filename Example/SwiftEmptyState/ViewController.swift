//
//  ViewController.swift
//  SwiftEmptyState_Example
//
//  Created by Enes Karaosman on 26.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEmptyState
import SnapKit

extension UIView { // SnapKit
    var safeArea: ConstraintAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

class ViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 0.7659385783, blue: 0.8678031315, alpha: 1)
        return v
    }()
    
    lazy var emptyStateManager: EmptyStateManager = {
        
        let esv = EmptyStateView(
            messageText: "This is label belongs to empty state view that sits in UIViewController's UIView",
            titleText: "Empty State Title",
            image: #imageLiteral(resourceName: "icon_404")
        )
        
        let manager = EmptyStateManager(
            containerView: self.containerView,
            emptyView: esv,
            animationConfiguration: .init(animationType: .fromLeft)
        )
        manager.hasContent = {
            !self.dataSource.isEmpty
        }
        
        return manager
    }()
    
    var dataSource = (1...50).map { _ in UIColor.random } {
        didSet {
            self.emptyStateManager.reloadState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let header = UILabel()
        header.text = "Dummy Header"
        header.textAlignment = .center
        header.layer.borderColor = UIColor.black.cgColor
        header.layer.borderWidth = 2
        
        let footer = UILabel()
        footer.text = "Dummy Footer"
        footer.textAlignment = .center
        footer.layer.borderColor = UIColor.black.cgColor
        footer.layer.borderWidth = 2
        
        self.view.addSubview(header)
        self.view.addSubview(footer)
        self.view.addSubview(containerView)
        
        header.snp.makeConstraints {
            $0.top.equalTo(self.view.safeArea.top)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
        }

        footer.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeArea.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.equalTo(footer.snp.top)
        }
        
        setEnableEmptyStateBarButton()
        setDisableEmptyStateBarButton()
        
    }
    
}

extension ViewController: SampleController {
    
    func setDisableEmptyStateBarButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Disable Empty State", style: .plain, target: self, action: #selector(_disableEmptyStateTriggered)
        )
    }
    
    func setEnableEmptyStateBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Empty State", style: .plain, target: self, action: #selector(_emptyStateTriggered)
        )
    }
    
    @objc private func _emptyStateTriggered() {
        self.dataSource = []
    }
    
    @objc private func _disableEmptyStateTriggered() {
        self.dataSource = (1...50).map { _ in UIColor.random }
    }
    
}

