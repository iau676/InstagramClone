//
//  Comment.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 18.03.2023.
//

import Foundation
import FirebaseFirestore

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let comment: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.comment = dictionary["comment"] as? String ?? ""
    }
}

