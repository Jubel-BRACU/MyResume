//
//  NSMutableAttributedString+Extension.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/14/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    
    //generate attributabed strings
    func createAtrributedString(string text: String?) -> NSMutableAttributedString {
        guard text != nil else {
            let error = "Error! Attributed String not created"
            return NSMutableAttributedString(string: error)
        }
        
        let attributedString = NSMutableAttributedString(string: text!)
        attributedString.addAttribute(.link, value: "https://"+text!, range: NSRange(location: 0, length: text!.count))
        
        return attributedString
    }
    
}
