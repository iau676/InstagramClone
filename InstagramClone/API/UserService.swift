//
//  UserService.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 16.03.2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
