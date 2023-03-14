//
//  MainTabController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 10.03.2023.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        configureViewControllers()
    }
    
    //MARK: - API
    
    private func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    //MARK: - Helpers

    private func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: Images.home_unselected,
                                                selectedImage: Images.home_selected,
                                                rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: Images.search_unselected,
                                                  selectedImage: Images.search_selected,
                                                  rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: Images.plus_unselected,
                                                         selectedImage: Images.plus_unselected,
                                                         rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationController(unselectedImage: Images.like_unselected,
                                                         selectedImage: Images.like_selected,
                                                         rootViewController: NotificationController())
        
        let profileLayout = UICollectionViewFlowLayout()
        let profile = templateNavigationController(unselectedImage: Images.profile_unselected,
                                                   selectedImage: Images.profile_selected,
                                                   rootViewController: ProfileController(collectionViewLayout: profileLayout))
        
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
