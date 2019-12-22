//
//  Enums.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/15/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

//Profile / Contact section
enum WebsiteLabel: Int {
    case linkedin = 0, github, businessWebsite
}

enum ContactLabel: Int {
    case name = 0, phone, email
}

enum ProfileTextViews: Int {
    case general = 0, valueProposition
}

//Segmentation sections
enum SegmentControl: Int {
    case experience = 0, projects, education, training
}

//Container Views
//enum ContainerView: Int {
//    case experience = 0, projects, education, training
//}

//Experience segement
enum ExperienceSection: Int {
    case professional = 0, developer
}
enum ProfessionalExperience: Int {
    case company = 0, location, period, jobTitle, description, accomplishments
}
enum DeveloperExperience: Int {
    case language = 0, location, period, projects, description
}

//iOS Projects Segment
enum ProjectSection: Int {
    case personal = 0, coursework
}

enum Project: Int {
    case projectName = 0, date, description, gitHub, technologies
    
}




