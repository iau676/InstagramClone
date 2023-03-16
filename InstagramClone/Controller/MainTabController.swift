//
//  MainTabController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 10.03.2023.
//

import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        fetchUser()
    }
    
    //MARK: - API
    
    private func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    private func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    //MARK: - Helpers

    private func configureViewControllers(withUser user: User) {
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
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: Images.profile_unselected,
                                                   selectedImage: Images.profile_selected,
                                                   rootViewController: profileController)
        
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

//MARK: - AuthenticationDelegate    

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true)
    }
}
