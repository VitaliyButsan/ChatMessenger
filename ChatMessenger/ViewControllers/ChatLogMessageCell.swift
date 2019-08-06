//
//  ChatLogMessageCell.swift
//  ChatMessenger
//
//  Created by vitaliy on 06/08/2019.
//  Copyright © 2019 vitaliy. All rights reserved.
//

import UIKit

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample of message"
        return textView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        addSubview(messageTextView)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false 
        messageTextView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        messageTextView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
}
