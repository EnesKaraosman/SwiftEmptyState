//
//  IEmptyStateView.swift
//  SwiftEmptyState
//
//  Created by Enes Karaosman on 18.02.2020.
//

import UIKit

public protocol IEmptyStateView where Self: UIView {
    var imageView: UIImageView { get set }
    var titleLabel: UILabel { get set }
    var titleFont: UIFont { get }
    var messageLabel: UILabel { get set }
    var messageFont: UIFont { get }
    var itemsToAnimate: [UIView] { get }
    var button: UIButton { get set }
    var buttonAction: ((UIButton) -> Void)? { get set }
}

public extension IEmptyStateView {
    
    var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .semibold)
    }
    
    var messageFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
}
