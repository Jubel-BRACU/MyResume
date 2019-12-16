//
//  UIImageView+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageViewProperties(borderWidth: CGFloat?, borderColor: UIColor?) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
            
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
