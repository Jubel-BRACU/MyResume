//
//  ResumeProtocol.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/12/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

//protocol method to pass json data to VC
protocol ResumeDelegate {
    func jsonDataLoaded(_ data: Resume, _ filename: String)
}
