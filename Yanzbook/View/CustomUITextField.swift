//
//  CustomUITextField.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import UIKit


class CustomUITextField: UITextField {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    

}
