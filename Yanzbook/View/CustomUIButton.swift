//
//  CustomUIButton.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomUIButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupUIButton()
        }
    }
    
    
    
    func setupUIButton(){
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 5
    }
}
