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
    
    //object initializer
//    init(contactInformation: [String: String], profile: [String: String], websites: [String: String], personalProjects: [[String: String]], courseworkProjects: [[String: String]], professionalExperience: [[String: String]], developerExperience: [String: String], experienceOverview: [String], generalSkills: [String], education: [[String: String]], industryCertifications: [[String: String]], projectBasedCourses: [[String: String]], foundationalCourses: [[String: String]], otherCertifications: [String: String], hobbies: [String]) {
//
//        self.contactInformation = contactInformation
//        self.profile = profile
//        self.websites = websites
//        self.personalProjects = personalProjects
//        self.courseworkProjects = courseworkProjects
//        self.professionalExperience = professionalExperience
//        self.developerExperience = developerExperience
//        self.experienceOverview = experienceOverview
//        self.generalSkills = generalSkills
//        self.education = education
//        self.industryCertifications = industryCertifications
//        self.projectBasedCourses = projectBasedCourses
//        self.foundationalCourses = foundationalCourses
//        self.otherCertifications = otherCertifications
//        self.hobbies = hobbies
//    }
    
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
    
    func setContactInfoLabels(resume: Resume?, labels: [UILabel]) {
        guard resume != nil else { return }
        
        let dict = resume?.contactInformation.first
        for label in labels {
            
            switch label.tag {
            case ContactLabels.name.rawValue:
                label.text = dict?["name"]
                
            case ContactLabels.phone.rawValue:
                label.text = dict?["phone"]
                
            case ContactLabels.email.rawValue:
                label.text = dict?["email"]
                
            default:
                break
            }
        }
    }

    func setWebsiteLabels(resume: Resume?, labels: [UILabel]) {
        guard resume != nil else { return }
        
        let dict = resume?.websites.first
        for label in labels {
            let attributedString = NSMutableAttributedString()
            
            switch label.tag {
            case WebsiteLabels.linkedin.rawValue:
                let string = dict!["linkedin"]!
                let text = attributedString.createAtrributedString(string: string)
                label.attributedText = text
                
            case WebsiteLabels.github.rawValue:
                let string = dict!["github"]!
                let text = attributedString.createAtrributedString(string: string)
                label.attributedText = text
                
            case WebsiteLabels.businessWebsite.rawValue:
                let string = dict!["businesss website"]!
                let text = attributedString.createAtrributedString(string: string)
                label.attributedText = text
                
            default:
                break
            }
        }
    }
}


