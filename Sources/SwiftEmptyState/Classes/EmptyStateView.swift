//
//  EmptyStateView.swift
//  FBSnapshotTestCase
//
//  Created by Enes Karaosman on 18.02.2020.
//

import UIKit
import SnapKit

public class EmptyStateView: UIView, IEmptyStateView {
    
    public var itemsToAnimate: [UIView] {
        return stackViewContainer.arrangedSubviews
    }

    private var centerYOffset: CGFloat = 0
    
    public var buttonAction: ((UIButton) -> Void)?

    public lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(#colorLiteral(red: 0.206512084, green: 0.5339240219, blue: 1, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(_buttonAction(sender:)), for: .touchUpInside)
        return btn
    }()

    @objc func _buttonAction(sender: UIButton) {
        self.buttonAction?(sender)
    }
    
    public var image: UIImage? {
        didSet {
            self.imageView.image = self.image
        }
    }
    
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    public var messageText: String? {
        didSet {
            messageLabel.text = messageText
        }
    }
    
    public var buttonText: String? {
        didSet {
            button.setTitle(buttonText, for: .normal)
        }
    }
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = self.image
        return iv
    }()
    
    private lazy var imageContainer: UIView = {
        let v = UIView()
        v.addSubview(imageView)
        return v
    }()
    
    private lazy var stackViewContainer: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageContainer, titleLabel, messageLabel, button])
        sv.spacing = 16
        sv.distribution = .fill
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    private lazy var mainContainer: UIView = {
        let v = UIView()
        v.addSubview(stackViewContainer)
        v.backgroundColor = .clear
        return v
    }()
    
    public lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = self.titleFont
        return lbl
    }()
    
    public lazy var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = self.messageFont
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        return lbl
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public init(
        messageText: String,
        titleText: String? = nil,
        image: UIImage? = nil,
        buttonText: String? =  nil,
        centerYOffset: CGFloat = 0
    ) {
        super.init(frame: CGRect.zero)
        setup(messageText: messageText, titleText: titleText, image: image, buttonText: buttonText, centerYOffset: centerYOffset)
        setupUI()
    }
    
    public func setup(messageText: String, titleText: String?, image: UIImage?, buttonText: String?, centerYOffset: CGFloat) {
        self.messageText = messageText
        self.titleText = titleText
        self.image = image
        self.buttonText = buttonText
        self.centerYOffset = centerYOffset
        self.messageLabel.sizeToFit()
        self.titleLabel.sizeToFit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        
        self.addSubview(mainContainer)
        
        self.mainContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.stackViewContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(self.centerYOffset)
        }
        
        self.imageContainer.snp.makeConstraints {
            $0.height.equalTo(self.image != nil ? 120 : 0)
        }
        
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
