//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 17.03.2023.
//

import UIKit

class UploadPostController: UIViewController {
    
    //MARK: - Properties
    
    private let photoImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = Images.venom
        return iv
    }()
    
    private lazy var captionTextView: UITextView = {
       let tv = InputTextView()
        tv.placeholderText = "Enter caption.."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapDone() {
        print("DEBUG: Share post here..")
    }
    
    @objc private func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done,
                                                            target: self, action: #selector(didTapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(width: 180, height: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor,
                               right: view.rightAnchor, paddingTop: 16, paddingLeft: 12,
                               paddingRight: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: captionTextView.rightAnchor,
                                   paddingBottom: -8, paddingRight: 12)
        
    }

}

//MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
