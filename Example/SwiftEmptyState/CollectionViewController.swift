//
//  CollectionViewController.swift
//  SwiftEmptyState_Example
//
//  Created by Enes Karaosman on 18.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEmptyState

class CollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "cv.cell"
    
    lazy var emptyStateManager: EmptyStateManager = {
        
        let esv = EmptyStateView(
            messageText: "This is label belongs to empty state view that sits in UICollectionViewController's UICollectionView",
            titleText: "Empty State Title",
            image: nil, // #imageLiteral(resourceName: "icon_404"),
            buttonText: "CV Demo Button"
        )
        esv.buttonAction = { _ in
            esv.messageText = "Button action works 👍🏻"
        }
        
        let manager = EmptyStateManager.init(containerView: self.collectionView!, emptyView: esv)
        return manager
    }()
    
    var dataSource = (1...50).map { _ in UIColor.random } {
        didSet {
            self.collectionView?.reloadData()
            self.emptyStateManager.reloadState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.collectionView!.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
        
        // Add Bar Buttons
        setEnableEmptyStateBarButton()
        setDisableEmptyStateBarButton()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = dataSource[indexPath.row]
        return cell
    }

}

extension CollectionViewController: SampleController {
    
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

// MARK: - Collection View Cell Size
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let collectionCellSize = collectionView.frame.size.width - padding
        return .init(width: collectionCellSize / 3, height: 60)
    }
}
