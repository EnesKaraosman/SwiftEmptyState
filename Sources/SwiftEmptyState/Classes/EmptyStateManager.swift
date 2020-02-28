
import UIKit
import SnapKit

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
                    UIView.animate(withDuration: 0.2, animations: {
                        self.emptyView.transform = self.animationDict[.spring]!
                        self.emptyView.alpha = 0
                    }, completion: { (_) in
                        self.emptyView.removeFromSuperview()
                    })
                }
            }
            return
        }
        
        loadEmptyView()
        
    }
    
    func loadEmptyView() {
        DispatchQueue.main.async {

            self.containerView.addSubview(self.emptyView)
            self.emptyView.snp.makeConstraints {
                $0.left.equalTo(self.containerView.safeArea.left)
                $0.right.equalTo(self.containerView.safeArea.right)
                $0.top.equalTo(self.containerView.safeArea.top)
                $0.bottom.equalTo(self.containerView.safeArea.bottom)
            }
            
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
            subItemDelayConstant: Double = 0.1,
            springDamping: CGFloat = 0.7,
            initialVelocity: CGFloat = 0.2,
            options: UIView.AnimationOptions = .curveEaseIn
        ) {
            self.animationType = animationType
            self.animationDuration = animationDuration
            self.subItemDelayConstant = subItemDelayConstant
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
    
    private func flushEmptyViewAnimationState() {
        self.emptyView.transform = .identity
        self.emptyView.alpha = 1
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
                delay: 0.1,
                usingSpringWithDamping: self.animationConfiguration.springDamping,
                initialSpringVelocity: self.animationConfiguration.initialVelocity,
                options: self.animationConfiguration.options,
                animations: {
                    self.flushEmptyViewAnimationState()
                },
                completion: completion
            )
        default:
            
            var temp = self.emptyView.itemsToAnimate
            
            if self.animationConfiguration.animationType == .fromTop {
                temp.reverse()
            }
            
            self.flushEmptyViewAnimationState()
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
