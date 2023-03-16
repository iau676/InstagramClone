//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 16.03.2023.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.username
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
