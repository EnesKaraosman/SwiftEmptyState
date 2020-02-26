
import UIKit

public class EmptyStateManager {
    
    var containerView: UIView
    private var emptyView: IEmptyStateView
    
    // MARK: - Animation properties
    
    /// Configure animation or use as is (default value)
    public var animationConfiguration = AnimationConfiguration()
    
    private let animationDict: [AnimationType: CGAffineTransform] = [
        AnimationType.fromBottom : CGAffineTransform(translationX: 0, y: 1200),
        AnimationType.fromTop    : CGAffineTransform(translationX: 0, y: -1200),
        AnimationType.fromLeft   : CGAffineTransform(translationX: -1000, y: 0),
        AnimationType.fromRight  : CGAffineTransform(translationX: 1000, y: 0),
        AnimationType.spring     : CGAffineTransform(scaleX: 0.3, y: 0.3)
    ]
    
    /// To let manager know when to show/hide EmptyStateView
    public lazy var hasContent: (() -> Bool) = {
        if let cv = self.containerView as? UICollectionView {
            return cv.totalRowsCount > 0
        }
        if let tv = self.containerView as? UITableView {
            return tv.totalRowsCount > 0
        }
        return false
    }

    public init(containerView: UIView, emptyView: IEmptyStateView, animationConfiguration: AnimationConfiguration = .init()) {
        self.containerView = containerView
        self.emptyView = emptyView
        self.animationConfiguration = animationConfiguration
        self.emptyView.frame = self.containerView.frame
    }
    
    public func reloadState() {
        if hasContent() {
            if emptyView.isDescendant(of: containerView) {
                DispatchQueue.main.async {
                    self.emptyView.removeFromSuperview()
                }
            }
            return
        }
        
        loadEmptyView()
        
    }
    
    func loadEmptyView() {
        DispatchQueue.main.async {

            self.containerView.addSubview(self.emptyView)
            
            if let tableView = self.containerView as? UITableView {
                if tableView.tableFooterView == nil {
                    tableView.tableFooterView = UIView()
                }
            }
            
            self.animate()
        }
    }
    
}

// MARK: - Animation Methods.
extension EmptyStateManager {
    
    public struct AnimationConfiguration {
        let animationType: AnimationType
        let animationDuration: TimeInterval
        /// Specific for .fromRight, .fromLeft, .fromTop, .fromBottom animation type, handles subview item's delaying
        let subItemDelayConstant: Double
        /// For spring animation type
        let springDamping: CGFloat
        let initialVelocity: CGFloat
        let options: UIView.AnimationOptions
        public init(
            animationType: AnimationType = .fromBottom,
            animationDuration: TimeInterval = 0.7,
            delayConstant: Double = 0.15,
            springDamping: CGFloat = 0.7,
            initialVelocity: CGFloat = 0.2,
            options: UIView.AnimationOptions = .curveEaseIn
        ) {
            self.animationType = animationType
            self.animationDuration = animationDuration
            self.subItemDelayConstant = delayConstant
            self.springDamping = springDamping
            self.initialVelocity = initialVelocity
            self.options = options
        }
    }
    
    public enum AnimationType {
        case fromBottom
        case fromLeft
        case fromTop
        case fromRight
        case spring
    }
    
    private func prepareAnimation() {
        switch self.animationConfiguration.animationType {
        case .spring:
            self.emptyView.transform = self.animationDict[.spring]!
            self.emptyView.alpha = 0
        default:
            self.emptyView.itemsToAnimate.forEach {
                let animationType = self.animationConfiguration.animationType
                $0.transform = self.animationDict[animationType]!
            }
        }
    }
    
    private func animate(completion: ((Bool) -> Void)? = nil) {
        
        // Scale down, decrease alpha etc.
        prepareAnimation()
        
        switch self.animationConfiguration.animationType {
        case .spring:
            UIView.animate(
                withDuration: self.animationConfiguration.animationDuration,
                delay: 0.2,
                usingSpringWithDamping: self.animationConfiguration.springDamping,
                initialSpringVelocity: self.animationConfiguration.initialVelocity,
                options: self.animationConfiguration.options,
                animations: {
                    self.emptyView.transform = .identity
                    self.emptyView.alpha = 1
                },
                completion: completion
            )
        default:
            
            var temp = self.emptyView.itemsToAnimate
            
            if self.animationConfiguration.animationType == .fromTop {
                temp.reverse()
            }
            
            for (index, item) in temp.enumerated() {
                
                UIView.animate(
                    withDuration: self.animationConfiguration.animationDuration,
                    delay: Double(index) * self.animationConfiguration.subItemDelayConstant,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: self.animationConfiguration.initialVelocity,
                    options: self.animationConfiguration.options,
                    animations: {
                        item.transform = .identity
                    },
                    completion: completion
                )
                
            }
            
        }
    }
    
}
