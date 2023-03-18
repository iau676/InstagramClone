//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 17.03.2023.
//

import UIKit

struct PostViewModel {
    
    var post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var caption: String {
        return post.caption
    }
    
    var likesLabelText: String {
        if post.likes  != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage {
        return post.didLike ? Images.like_selected! : Images.like_unselected!
    }
    
    init(post: Post) {
        self.post = post
    }
    
}
