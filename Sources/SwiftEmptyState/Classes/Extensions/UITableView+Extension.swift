//
//  UITableView+Extension.swift
//  FBSnapshotTestCase
//
//  Created by Enes Karaosman on 18.02.2020.
//

import class UIKit.UITableView

public extension UITableView {

    var totalRowsCount: Int {
        let sections = self.numberOfSections
        var rows = 0

        for i in 0..<sections {
            rows += self.numberOfRows(inSection: i)
        }

        return rows
    }
    
}
