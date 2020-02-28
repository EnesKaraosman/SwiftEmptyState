//
//  UIColor+Extension.swift
//  SwiftEmptyState
//
//  Created by Enes Karaosman on 19.02.2020.
//

import class UIKit.UIColor

public extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
