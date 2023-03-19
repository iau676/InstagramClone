//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 19.03.2023.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = Images.venom
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "bird"
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(profileImageView)
        profileImageView.setDimensions(width: 48, height: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profileImageView,
                          leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func handlePostTapped() {
        
    }
}
