//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 14.03.2023.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: AnyObject {
    func header(_ profileHeader: ProfileHeader, didTapActionButtunFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.grid, for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.list, for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.ribbon, for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                         paddingTop: 12, paddingLeft: 12)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                       paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor,
                     paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func handleEditProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtunFor: viewModel.user)
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgrouncColor
        
        postsLabel.attributedText = viewModel.numberOfPosts
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
        
    }
}
