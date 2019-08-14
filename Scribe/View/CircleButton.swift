//
//  CircleButton.swift
//  Scribe
//
//  Created by MacBook Pro on 8/13/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

@IBDesignable

class CircleButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 30 {
        didSet {
            setupView()
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = cornerRadius
    }
}
