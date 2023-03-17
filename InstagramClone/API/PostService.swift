//
//  PostService.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 17.03.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct PostService {
        
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestoreComletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
}
