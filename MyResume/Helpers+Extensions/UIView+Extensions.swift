//
//  UIView+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //set view attributes
    func setProperties(borderWidth: CGFloat?, borderColor: UIColor?, cornerRadius: CGFloat?) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
            
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    //set view shape to circle
    func makeCircle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
