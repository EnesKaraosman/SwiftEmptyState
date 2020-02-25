//
//  EmptyStateView.swift
//  FBSnapshotTestCase
//
//  Created by Enes Karaosman on 18.02.2020.
//

import UIKit

public class EmptyStateView: UIView, IEmptyStateView {

    private let spacing = 16
    
    public var buttonAction: ((UIButton) -> Void)?
    
    public lazy var imageView: UIImageView? = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "icon_no_content") // placeholder
        return iv
    }()
    
    public lazy var titleLabel: UILabel? = {
        let lbl = UILabel()
        lbl.text = "Title Label"
        lbl.font = self.titleFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        lbl.font = self.descriptionFont
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = #colorLiteral(red: 0.4258198728, green: 0.4906104731, blue: 0.5, alpha: 1)
        return lbl
    }()
    
    public lazy var button: UIButton? = {
        let btn = UIButton()
        btn.setTitle("BUTTON", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.206512084, green: 0.5339240219, blue: 1, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(_buttonAction(sender:)), for: .touchUpInside)
        btn.layer.borderColor = #colorLiteral(red: 0.206512084, green: 0.5339240219, blue: 1, alpha: 1)
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 20
        return btn
    }()

    @objc func _buttonAction(sender: UIButton) {
        self.buttonAction?(sender)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() {
        
        // Optional UI Element
        if let _imageView = imageView {
            self.addSubview(_imageView)
            
            _imageView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalTo(self.frame.height * 0.25)
                $0.height.equalTo(120)
            }
        }
        
        // Optional UI Element
        if let _titleLabel = titleLabel {
            self.addSubview(_titleLabel)
            
            _titleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().inset(spacing)
                $0.height.equalTo(40)
                $0.top.equalTo(self.imageView?.snp.bottom ?? self.frame.height * 0.35).offset(spacing)
            }
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(spacing)
            $0.top.equalTo(self.titleLabel?.snp.bottom ?? self.frame.height * 0.4).offset(spacing)
        }
        
        // Optional UI Element
        if let _button = button {
            self.addSubview(_button)
        
            _button.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.6)
                $0.height.equalTo(40)
                $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(spacing)
            }
            
        }
        
    }
    
}
