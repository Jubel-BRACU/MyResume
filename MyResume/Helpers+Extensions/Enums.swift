//
//  Enums.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/15/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

enum WebsiteLabels: Int {
    case linkedin = 0, github, businessWebsite
}

enum ContactLabels: Int {
    case name = 0, phone, email
}

enum ProfileTextViews: Int {
    case general = 0, valueProposition
}

enum ProfessionalExperience: Int {
    case company = 0, location, period, jobTitle, description, accomplishments
}

enum DeveloperExperience: Int {
    case language = 0, location, period, projects, description
}

enum ExperienceSection: Int {
    case professionalExperience = 0, developerExperience
    
}

enum SegmentControl: Int {
    case experience = 0, iosProjects, education, swiftTraining
}


