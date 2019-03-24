//
//  WordButton.swift
//  Project8
//
//  Created by Eric Sans Alvarez on 24/03/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class WordButton: UIButton {
    
    var isClear: Bool = false {
        willSet {
            alpha = newValue == true ? 0.3 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 36)
        setTitleColor(.black, for: .normal)
        
        // Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }
}
