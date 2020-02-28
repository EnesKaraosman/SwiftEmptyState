//
//  UIView+Extension.swift
//  SwiftEmptyState
//
//  Created by Enes Karaosman on 26.02.2020.
//

import class UIKit.UIView
import SnapKit

extension UIView {
    var safeArea: ConstraintAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}
