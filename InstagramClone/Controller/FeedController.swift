//
//  FeedController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 10.03.2023.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    //MARK: - Lifecycle
    
    private var posts = [Post]()
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - API
    
    private func fetchPosts() {
        
        guard post == nil else { return }
        
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Selectors
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.title = "Feed"
        
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain,
                                                               target: self,
                                                               action: #selector(handleLogout))
        }
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        cell.delegate = self
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}


//MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowComments post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
}
