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
    
    var messages: [Message]?
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let entityNames = ["Friend", "Message"]
            
            for entityName in entityNames {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                
                do {
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    for object in objects! {
                        context.delete(object)
                    }
                    try context.save()
                } catch {
                    
                }
            }
        }
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do {
                messages = try context.fetch(fetchRequest) as? [Message]
            } catch {
                print(error)
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = delegate.persistentContainer.viewContext

        let porokh = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        porokh.name = "Poroshenko Pavlo"
        porokh.profileImageName = "3"

        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = porokh
        message.text = "Hello, friends. I writte fine programm for all of your's."
        message.date = Date()
        //----------------------------------------------------
        let karl = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        karl.name = "Karl"
        karl.profileImageName = "4"

        let karlMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        karlMessage.friend = karl
        karlMessage.text = "Hello, friends. I writte fine programm for all of your's."
        karlMessage.date = Date()

        do {
            try context.save()
        } catch {
            print(error)
        }
        
        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = Constants.mainTitle
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        setupData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        } else {
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        if let message = messages?[indexPath.row] {
            cell.message = message
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.cellHeight)
    }
}
