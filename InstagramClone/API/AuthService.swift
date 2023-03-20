//
//  AuthService.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 14.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let userData: [String: Any] = ["email": credentials.email,
                                               "fullname": credentials.fullname,
                                               "profileImageUrl": imageUrl,
                                               "uid": uid,
                                               "username": credentials.username]
                
                COLLECTION_USERS.document(uid).setData(userData, completion: completion)
            }
        }
    }
    
    static func resetPassword(withEmail email: String, completion: @escaping((Error?) -> Void)) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
}
