//
//  TableViewController.swift
//  SwiftEmptyState_Example
//
//  Created by Enes Karaosman on 18.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEmptyState

class TableViewController: UITableViewController {
    
    private let reuseIdentifier = "tv.cell"
    
    lazy var emptyStateManager: EmptyStateManager = {
        
        let ev = EmptyStateView(
            messageText: "Table VIEW",
            titleText: "Table view description",
            image: #imageLiteral(resourceName: "icon_404"),
            buttonText: nil,
//            buttonText: "CV Demo Button",
            centerYOffset: -40
        )
        
        let manager = EmptyStateManager.init(
            containerView: self.view,
            emptyView: ev,
            animationConfiguration: .init(animationType: .spring)
        )
        return manager
    }()
    
    var dataSource = (1...50).map { _ in UIColor.random } {
        didSet {
            self.tableView.reloadData()
            self.emptyStateManager.reloadState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.7533465844, green: 0.9165241449, blue: 0.9036050066, alpha: 1)
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: reuseIdentifier
        )

        emptyStateManager.reloadState()
        
        // Add Bar Buttons
        setEnableEmptyStateBarButton()
        setDisableEmptyStateBarButton()
        
    }
    
    // MARK: - Table view

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = dataSource[indexPath.row]
        return cell
    }

}

extension TableViewController: SampleController {
    
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
