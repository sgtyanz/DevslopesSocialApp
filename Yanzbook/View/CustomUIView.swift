//
//  CustomUIView.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            setupUIView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            setupUIView()
        }
    }
    
    @IBInspectable var shadowWidth: CGFloat = 0.0 {
        didSet {
            setupUIView()
        }
    }
    
    @IBInspectable var shadowHeight: CGFloat = 0.0 {
        didSet {
            setupUIView()
        }
    }

    func setupUIView() {
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        
    }

}
