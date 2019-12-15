//
//  OpenInSafari.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/15/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import SafariServices
import UIKit

//helper to open web links inside safari in app
extension ViewController {
    
    //load website via safari inside app
    func loadWebsite(url string: String) {
        let url = URL(string: string)!
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
}
