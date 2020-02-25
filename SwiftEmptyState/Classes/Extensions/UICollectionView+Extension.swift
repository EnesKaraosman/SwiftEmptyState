//
//  UICollectionView+Extension.swift
//  FBSnapshotTestCase
//
//  Created by Enes Karaosman on 18.02.2020.
//

import class UIKit.UICollectionView

public extension UICollectionView {

    var totalRowsCount: Int {
        let sections = self.numberOfSections
        var rows = 0

        for i in 0..<sections {
            rows += self.numberOfItems(inSection: i)
        }

        return rows
    }
    
}
