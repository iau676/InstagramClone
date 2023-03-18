//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 18.03.2023.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var username: String {
        return comment.username
    }
    
    var commentText: String {
        return comment.comment
    }
    
    var commentLabelText: NSAttributedString {
        return commentLabelText(username: username, comment: commentText)
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    private func commentLabelText(username: String, comment: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(username) ",
                                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\(comment)",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributedText
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
