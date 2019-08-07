//
//  CustomTabBarController.swift
//  ChatMessenger
//
//  Created by vitaliy on 06/08/2019.
//  Copyright © 2019 vitaliy. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup custom view controllers
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendsController)
        recentMessageNavController.tabBarItem.title = "Recent"
        recentMessageNavController.tabBarItem.image = UIImage(named: "recent-30")

        
        viewControllers = [ recentMessageNavController,
                            createNavControllerWithTitle(title: "Call", imageName: "phone-28"),
                            createNavControllerWithTitle(title: "Group", imageName: "groups-30"),
                            createNavControllerWithTitle(title: "People", imageName: "people-30"),
                            createNavControllerWithTitle(title: "Settings", imageName: "settings-30") ]
    }
    
    private func createNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        let recentNavController = UINavigationController(rootViewController: viewController)
        recentNavController.tabBarItem.title = title
        recentNavController.tabBarItem.image = UIImage(named: imageName)
        
        return recentNavController
    }
}
