//
//  FeedCell.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 11.03.2023.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowComments post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
}

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        iv.setDimensions(width: 32, height: 32)
        iv.layer.cornerRadius = 32 / 2
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.like_unselected, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.comment, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.send2, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12)
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor,
                          paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor,
                            paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor,
                            paddingTop: 8, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func didTapUsername() {
        print("didTapUsername")
    }
    
    @objc private func didTapLike() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
    
    @objc private func didTapComments() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowComments: viewModel.post)
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        likesLabel.text = viewModel.likesLabelText
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
    }
    
    private func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
}
