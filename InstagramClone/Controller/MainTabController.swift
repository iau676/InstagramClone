//
//  MainTabController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 10.03.2023.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    //MARK: - Helpers

    private func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: UIImage(named: "home_unselected"),
                                                selectedImage: UIImage(named: "home_selected"),
                                                rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: UIImage(named: "search_unselected"),
                                                  selectedImage: UIImage(named: "search_selected"),
                                                  rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: UIImage(named: "plus_unselected"),
                                                         selectedImage: UIImage(named: "plus_selected"),
                                                         rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(unselectedImage: UIImage(named: "like_unselected"),
                                                         selectedImage: UIImage(named: "like_selected"),
                                                         rootViewController: NotificationController())
        
        let profile = templateNavigationController(unselectedImage: UIImage(named: "profile_unselected"),
                                                   selectedImage: UIImage(named: "profile_selected"),
                                                   rootViewController: ProfileController())
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        
        tabBar.tintColor = .black
        
        
    }
    
    private func templateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .blue
        return nav
    }

}
