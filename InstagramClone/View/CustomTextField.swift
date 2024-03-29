//
//  CustomTextField.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 13.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(width: 12, height: 50)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        tintColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        layer.cornerRadius = 5
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
