//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 19.03.2023.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    
    var postId: String {
        return notification.postId
    }
    
    var postImageUrl: URL? {
        return URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        return URL(string: notification.userProfileImageUrl)
    }
    
    var timestampString: String {
             let formatter = DateComponentsFormatter()
             formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
             formatter.maximumUnitCount = 1
             formatter.unitsStyle = .abbreviated
             return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? "2m"
         }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attributedText = NSMutableAttributedString(string: username,
                                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: message,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: " \(timestampString)",
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
