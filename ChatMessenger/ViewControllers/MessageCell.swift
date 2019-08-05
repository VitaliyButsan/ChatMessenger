//
//  ChatTableViewCell.swift
//  ChatMessenger
//
//  Created by vit on 26/07/2019.
//  Copyright © 2019 vit. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private struct Constants {
        static let profileImageCornerRadius: CGFloat = 35.0
        static let profileImageLeft: CGFloat = 10.0
        static let profileImageHeight: CGFloat = 70.0
        static let profileImageWidth: CGFloat = 70.0
        static let profileImage: UIImage = UIImage(named: "3")!
        
        static let deviderLineLeft: CGFloat = 0.0
        static let deviderLineRight: CGFloat = -5.0
        static let deviderLineCenterY: CGFloat = 0.0
        static let deviderLineHeight: CGFloat = 1.0
        static let deviderColor: UIColor = #colorLiteral(red: 0.4116632297, green: 0.4116632297, blue: 0.4116632297, alpha: 0.4780875428)
        
        static let containerViewLeft: CGFloat = 10.0
        static let containerViewRight: CGFloat = 0.0
        static let containerViewHeight: CGFloat = 70.0
        
        static let nameLabelLeft: CGFloat = 0.0
        static let nameLabelTop: CGFloat = 10.0
        static let nameLabelHeight: CGFloat = 20.0
        static let nameLabelFontSize: CGFloat = 18.0
        
        static let messageLabelLeft: CGFloat = 0.0
        static let messageLabelRight: CGFloat = -40.0
        static let messageLabelBottom: CGFloat = -10.0
        static let messageLabelHeight: CGFloat = 20.0
        static let messageLabelFontSize: CGFloat = 14.0
        
        static let timeLabelRight: CGFloat = -10.0
        static let timeLabelHeight: CGFloat = 20.0
        static let timeLabelCenterY: CGFloat = 0.0
        static let timLabelFontSize: CGFloat = 14.0
        
        static let hasReadViewRight: CGFloat = -12.0
        static let hasReadViewCenterY: CGFloat = 0.0
        static let hasReadViewHeight: CGFloat = 20.0
        static let hasReadViewWidth: CGFloat = 20.0
        static let hasReadViewCornerRadius: CGFloat = 10.0
        static let hasReadImage: UIImage = UIImage(named: "1")!
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.profileImage
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = Constants.profileImageCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let deviderLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = Constants.deviderColor
        return lineView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize, weight: .medium)
        name.text = "Poroshenko"
        return name
    }()

    private let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: Constants.messageLabelFontSize)
        messageLabel.text = "Some message text template, for new conversation..."
        messageLabel.textColor = .darkGray
        return messageLabel
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: Constants.timLabelFontSize)
        timeLabel.text = "12.00AM"
        return timeLabel
    }()
    
    private let hasReadImageView: UIImageView = {
        let readImageView = UIImageView()
        readImageView.image = Constants.hasReadImage
        readImageView.contentMode = .scaleToFill
        readImageView.layer.cornerRadius = Constants.hasReadViewCornerRadius
        readImageView.clipsToBounds = true
        return readImageView
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        setupContainerView()
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.profileImageLeft).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageHeight).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageWidth).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(deviderLineView)
        deviderLineView.translatesAutoresizingMaskIntoConstraints = false
        deviderLineView.heightAnchor.constraint(equalToConstant: Constants.deviderLineHeight).isActive = true
        deviderLineView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: Constants.deviderLineLeft).isActive = true
        deviderLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Constants.deviderLineRight).isActive = true
        deviderLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.deviderLineCenterY).isActive = true
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: Constants.containerViewLeft).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Constants.containerViewRight).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: Constants.containerViewHeight).isActive = true
        
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.nameLabelLeft).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.nameLabelTop).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelHeight).isActive = true
        
        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.messageLabelLeft).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: Constants.messageLabelRight).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.messageLabelBottom).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: Constants.messageLabelHeight).isActive = true
        
        containerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: Constants.timeLabelRight).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: Constants.timeLabelHeight).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: Constants.timeLabelCenterY).isActive = true
        
        containerView.addSubview(hasReadImageView)
        hasReadImageView.translatesAutoresizingMaskIntoConstraints = false
        hasReadImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: Constants.hasReadViewRight).isActive = true
        hasReadImageView.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor, constant: Constants.hasReadViewCenterY).isActive = true
        hasReadImageView.heightAnchor.constraint(equalToConstant: Constants.hasReadViewHeight).isActive = true
        hasReadImageView.widthAnchor.constraint(equalToConstant: Constants.hasReadViewWidth).isActive = true
    }
}

