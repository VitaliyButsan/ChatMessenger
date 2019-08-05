//
//  Message+CoreDataProperties.swift
//  ChatMessenger
//
//  Created by vitaliy on 31/07/2019.
//  Copyright © 2019 vitaliy. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var friend: Friend?

}
