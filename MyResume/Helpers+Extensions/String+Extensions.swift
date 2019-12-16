//
//  NSMutableAttributedString+Extension.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/14/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

extension String {
    
    //generate attributabed string
    func createAtrributedString(type: String) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.link, value: type+self, range: NSRange(location: 0, length: self.count))
        return attributedString
    }
}
