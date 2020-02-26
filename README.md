# SwiftEmptyState

[![CI Status](https://img.shields.io/travis/eneskaraosman/SwiftEmptyState.svg?style=flat)](https://travis-ci.org/eneskaraosman/SwiftEmptyState)
[![Version](https://img.shields.io/cocoapods/v/SwiftEmptyState.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyState)
[![License](https://img.shields.io/cocoapods/l/SwiftEmptyState.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyState)
[![Platform](https://img.shields.io/cocoapods/p/SwiftEmptyState.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyState)

## Why do I need?

Common usage case;

**TLDR**;<br/> 
Image you're getting data from a backend, your request succeded but it is just an empty list.
Don't left user with a blank screen, or boring alerts.

**Blog link will come here..**

## Usage

For better understanding, please view Example project.

But here below the main concept.

Usable in any UITableViewController, UICollectionViewController and UIViewController


```swift

class TableViewController: UITableViewController {
    
    lazy var emptyStateManager: EmptyStateManager = {
        
        let esv = EmptyStateView(
            messageText: "Table VIEW",
            titleText: "Table view description",
            image: UIImage(named: "empty_state_image"),
            buttonText: nil,
            centerYOffset: -40
        )
        
        let manager = EmptyStateManager.init(
            containerView: self.tableView,
            emptyView: esv,
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
    
    // dataSource is the dataSource of tableView
}
```

Same example valid for UICollectionView contentView

## Animation

EmptyStateManager has animationConfiguration parameter with default values.

```swift
struct AnimationConfiguration {
    let animationType: AnimationType     // .spring, .fromBottom, .fromLeft, .fromTop, .fromRight
    let animationDuration: TimeInterval
    let subItemDelayConstant: Double     // image, titleLabel, messageLabel, button. Except .spring animation
    let springDamping: CGFloat           // .spring animation case
    let initialVelocity: CGFloat
    let options: UIView.AnimationOptions
}

let manager = EmptyStateManager(
    containerView: ***,
    emptyView: ***,
    animationConfiguration: .init(animationType: .spring)
)
```

## Customization

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftEmptyState is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftEmptyState'
```

## Author

eneskaraosman, eneskaraosman53@gmail.com

## License

SwiftEmptyState is available under the MIT license. See the LICENSE file for more info.
