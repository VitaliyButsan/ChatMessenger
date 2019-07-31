//
//  ViewController.swift
//  ChatMessenger
//
//  Created by vit on 25/07/2019.
//  Copyright © 2019 vit. All rights reserved.
//

import UIKit
import CoreData

class FriendsController: UICollectionViewController {
    
    private struct Constants {
        static let cellIdentifier: String = "Cell"
        static let mainTitle: String = "Recent"
        static let cellHeight: CGFloat = 100.0
    }
    /*
    var messages: [Message]?
    
    func setupData() {
    
        //let delegate = UIApplication.sharedApplication().delegate
        if 3 < 2 {
        
            let porokh = Friend()
            porokh.name = "Poroshenko Pavlo"
            porokh.profileImageName = "3"
            
            let message = Message()
            message.friend = porokh
            message.text = "Hello, friends. I writte fine programm for all of your's."
            message.date = Date()
            //----------------------------------------------------
            let karl = Friend()
            karl.name = "Karl"
            karl.profileImageName = "4"
            
            let karlMessage = Message()
            karlMessage.friend = karl
            karlMessage.text = "Hello, friends. I writte fine programm for all of your's."
            karlMessage.date = Date()
            
            messages = [message, karlMessage]
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = Constants.mainTitle
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        //setupData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if let count = messages?.count {
        //    return count
        //} else {
            return 1
        //}
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        //if let message = messages?[indexPath.row] {
        //    cell.message = message
        //}
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.cellHeight)
    }
}

