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
        let emptyView = EmptyStateView(frame: self.view.frame)
        // Avoid setting background, due to TableView's default contentInset
        // Instead set .clear color & set container view's background
        emptyView.titleLabel?.text = "TABLE VIEW"
        emptyView.imageView?.image = #imageLiteral(resourceName: "icon_404")
        emptyView.buttonAction = { btn in
            print("Empty view in TableView, button action")
        }
        
        let m = EmptyStateManager.init(containerView: self.view, emptyView: emptyView)
        // Optional
        m.hasContent = {
            self.dataSource.count > 0
        }
        return m
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
