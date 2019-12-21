//
//  CVModel.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/11/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

struct Resumes: Decodable {
    var resumes: [Resume]
}

struct Resume: Decodable {
    
    //versioning properties
    let date = "December, 2019"
    let version = "1.0"
    
    //contact properties
    let contactInformation: [[String: String]]
    let profile: [[String: String]]
    let websites: [[String: String]]
    let personalProjects: [[String: String]]
    let courseworkProjects: [[String: String]]
    let professionalExperience: [[String: String]]
    let developerExperience: [[String: String]]
    let experienceOverview: [[String: String]]
    let skills: [String]
    let education: [[String: String]]
    let industryCertifications: [[String: String]]
    let projectBasedCourses: [[String: String]]
    let foundationalCourses: [[String: String]]
    let otherCertifications: [[String: String]]
    let hobbies: [String]
    
    //Map Resume propertiy names, to json data field names
    enum CodingKeys: String, CodingKey {

        case contactInformation = "contact information"
        case profile
        case websites
        case personalProjects = "personal projects"
        case courseworkProjects = "coursework projects"
        case professionalExperience = "professional experience"
        case developerExperience = "developer experience"
        case experienceOverview = "experience overview"
        case skills
        case education
        case industryCertifications = "industry certifications"
        case projectBasedCourses = "swift project based courses"
        case foundationalCourses = "swift foundational courses"
        case otherCertifications = "other certifications"
        case hobbies
    }
    
    
    //MARK: - Methods to pull out data from dictionaries
    func getDictKeys(dictionary: [String:String]) -> [String] {
        
        //get keys and insert into new array in same order
        var keys = [String]()
        
        for key in dictionary.keys {
            keys.insert(key, at: keys.startIndex)
        }
        
        return keys
    }
    
    
    
    
}


