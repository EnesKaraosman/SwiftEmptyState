
import UIKit

public protocol EmptyStateViewProtocol: class {
    func hasContent() -> Bool
    func loadEmptyView()
    func reloadEmptyViewState()
//    var containerView: UIView { get }
//    var emptyStateView: UIView { get }
}

public protocol EmptyStateManagerDelegate: class {
    
}

public extension EmptyStateManagerDelegate where Self: UIViewController {
    
}

public class EmptyStateManager {
    
    var containerView: UIView
    private var emptyView: UIView
    public weak var delegate: EmptyStateManagerDelegate?
    
    // MARK: - Animation properties
    
    public var animationConfiguration = AnimationConfiguration()
    
    private var animationType = AnimationType.fromBottom
    
    private var itemsToAnimate: [UIView] {
        return emptyView.subviews
    }
    
    private let animationDict: [AnimationType: CGAffineTransform] = [
        AnimationType.fromBottom : CGAffineTransform(translationX: 0, y: 1200),
        AnimationType.fromTop    : CGAffineTransform(translationX: 0, y: -1200),
        AnimationType.fromLeft   : CGAffineTransform(translationX: -1000, y: 0),
        AnimationType.fromRight  : CGAffineTransform(translationX: 1000, y: 0),
        AnimationType.spring     : CGAffineTransform(scaleX: 0.3, y: 0.3)
    ]
    
    /////////
    
    public lazy var hasContent: (() -> Bool) = {
        if let cv = self.containerView as? UICollectionView {
            return cv.totalRowsCount > 0
        }
        if let tv = self.containerView as? UITableView {
            return tv.totalRowsCount > 0
        }
        return false
    }

    public init(containerView: UIView, emptyView: UIView, animationConfiguration: AnimationConfiguration = .init()) {
        self.containerView = containerView
        self.emptyView = emptyView
        self.animationConfiguration = animationConfiguration
    }
    
    public func reloadState() {
        if hasContent() {
            if emptyView.isDescendant(of: containerView) {
                DispatchQueue.main.async {
                    self.emptyView.removeFromSuperview()
//                    self.delegate?.disconnect(vc: self.emptyStateViewController)
                }
            }
            return
        }
        
        loadEmptyView()
        
    }
    
    func loadEmptyView() {
        DispatchQueue.main.async {

//            self.delegate?.connect(vc: self.emptyStateViewController)
            
            self.containerView.addSubview(self.emptyView)
            self.animate()
            
            if let tableView = self.containerView as? UITableView {
                if tableView.tableFooterView == nil {
                    tableView.tableFooterView = UIView()
                }
            }
        }
    }
    
}

// MARK: - Animation Methods.
extension EmptyStateManager {
    
    public struct AnimationConfiguration {
        public var animationType: AnimationType = .fromBottom
        public var animationDuration: TimeInterval = 0.7
        /// Specific for spring animation type, handles subview item's appearance
        public var delayConstant: Double = 0.15
        /// For spring animation type
        public var springDamping: CGFloat = 0.7
        public var initialVelocity: CGFloat = 0.2
        public var options: UIViewAnimationOptions = .curveEaseIn
        public init() { }
    }
    
    public enum AnimationType {
        case fromBottom
        case fromLeft
        case fromTop
        case fromRight
        case spring
    }
    
    private func prepareAnimation() {
        switch animationType {
        case .spring:
            self.emptyView.transform = self.animationDict[.spring]!
        default:
            self.itemsToAnimate.forEach {
                $0.transform = self.animationDict[animationType]!
            }
        }
    }
    
    private func animate(completion: ((Bool) -> Void)? = nil) {
        
        // Scale down, decrease alpha etc.
        prepareAnimation()
        
        switch self.animationType {
        case .spring:
            UIView.animate(
                withDuration: self.animationConfiguration.animationDuration,
                delay: 0.3,
                usingSpringWithDamping: self.animationConfiguration.springDamping,
                initialSpringVelocity: self.animationConfiguration.initialVelocity,
                options: self.animationConfiguration.options,
                animations: {
                    self.emptyView.transform = .identity
                },
                completion: completion
            )
        default:
            
            var temp = itemsToAnimate
            
            if self.animationType == .fromTop {
                temp.reverse()
            }
            
            for (index, item) in temp.enumerated() {
                
                UIView.animate(
                    withDuration: 0.7,
                    delay: Double(index) * self.animationConfiguration.delayConstant,
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
