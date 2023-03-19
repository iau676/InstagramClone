//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 19.03.2023.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    
    var postImageUrl: URL? {
        return URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        return URL(string: notification.userProfileImageUrl)
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attributedText = NSMutableAttributedString(string: username,
                                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: message,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: " 2m",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                              .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
    }
    
    init(notification: Notification) {
        self.notification = notification
    }
    
}
