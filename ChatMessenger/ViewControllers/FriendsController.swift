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
        static let friendEntityName: String = "Friend"
        static let messageEntityName: String = "Message"
    }
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = Constants.mainTitle
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        setupData()
    }
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let entityNames = [Constants.friendEntityName, Constants.messageEntityName]
            
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
            
            guard let friends = fetchFriends() else { return }
            messages = [Message]()
            
            for friend in friends {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.messageEntityName)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                
                do {
                    let fetchMessages = try context.fetch(fetchRequest) as? [Message]
                    messages?.append(contentsOf: fetchMessages!)
                } catch {
                    print(error)
                }
            }
            messages = messages?.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.friendEntityName)
            
            do {
                return try context.fetch(request) as? [Friend]
            } catch let error {
                print(error)
            }
        }
        return nil
    }
    
    func setupData() {
        
        clearData()
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = delegate.persistentContainer.viewContext

        let porokh = NSEntityDescription.insertNewObject(forEntityName: Constants.friendEntityName, into: context) as! Friend
        porokh.name = "Poroshenko Pavlo"
        porokh.profileImageName = "3"
 
        createMessageWithText(text: "Hello, friends.", friend: porokh, minutesAgo: 3, context: context)
        createMessageWithText(text: "Hello, friends. I'am here.", friend: porokh, minutesAgo: 2, context: context)
        createMessageWithText(text: "Hello, friends. I'am a new president", friend: porokh, minutesAgo: 1, context: context)
        //----------------------------------------------------
        let vladimir = NSEntityDescription.insertNewObject(forEntityName: Constants.friendEntityName, into: context) as! Friend
        vladimir.name = "Vladimir Zel"
        vladimir.profileImageName = "4"

        createMessageWithText(text: "Hello, i am a Vlidimir!", friend: vladimir, minutesAgo: 4, context: context)
        
        let kuchma = NSEntityDescription.insertNewObject(forEntityName: Constants.friendEntityName, into: context) as! Friend
        kuchma.name = "Kuchma Leonid"
        kuchma.profileImageName = "1"
        
        createMessageWithText(text: "My name is Leonid", friend: kuchma, minutesAgo: 60 * 24 * 8, context: context)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        loadData()
    }

    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        let message = NSEntityDescription.insertNewObject(forEntityName: Constants.messageEntityName, into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
    }
}

// MARK: - UICollectionViewDelegate

extension FriendsController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let chatController = ChatLogController(collectionViewLayout: layout)
        chatController.friend = messages?[indexPath.item].friend
        navigationController?.pushViewController(chatController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension FriendsController {
    
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
