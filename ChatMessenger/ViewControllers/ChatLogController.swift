//
//  ChatLogController.swift
//  ChatMessenger
//
//  Created by vitaliy on 06/08/2019.
//  Copyright © 2019 vitaliy. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var messages: [Message]?
    private let reuseIdentifier = "Cell"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending})
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

}

// MARK: - UICollectionViewDataSource

extension ChatLogController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.item].text
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatLogController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
