//
//  ResumeV2.swift
//  MyResume
//
//  Created by Simon Italia on 6/17/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

struct ResumeResponse: Codable {
    let resume: ResumeObject
}

// MARK: - Resume
struct ResumeObject: Codable {
    let fileInformation: FileInformationObject
    let contactInformation: ContactInformationObject
    let profile: ProfileObject
    let websites: [WebsiteObject]
    let personalProjects, courseworkProjects: [ProjectObject]
    let professionalExperience: [ProfessionalExperienceObject]
    let developerExperience: [DeveloperExperienceObject]
    let experienceOverview: [ExperienceOverviewObject]
    let skills: [SkillObject]
    let education: [EducationObject]
    let industryCertifications: [CertificationObject]
    let swiftProjectBasedCourses, swiftFoundationalCourses: [SwiftCourseObject]
    let otherCertifications: [CertificationObject]
    let hobbies: [HobbyObject]


    enum CodingKeys: String, CodingKey {
        case fileInformation = "file information"
        case contactInformation = "contact information"
        case profile, websites
        case personalProjects = "personal projects"
        case courseworkProjects = "coursework projects"
        case professionalExperience = "professional experience"
        case developerExperience = "developer experience"
        case experienceOverview = "experience overview"
        case skills, education
        case industryCertifications = "industry certifications"
        case swiftProjectBasedCourses = "swift project based courses"
        case swiftFoundationalCourses = "swift foundational courses"
        case otherCertifications = "other certifications"
        case hobbies
    }
}

// MARK: - ContactInformation
struct ContactInformationObject: Codable {
    let name, phone, email: String
}

// MARK: - Project
struct ProjectObject: Codable {
    let projectName, date: String
    let github: String
    let projectDescription, technologies: String
    let imageName: String?

    enum CodingKeys: String, CodingKey {
        case projectName = "project name"
        case date, github
        case projectDescription = "description"
        case technologies
        case imageName = "image"
    }
}


// MARK: - DeveloperExperience
struct DeveloperExperienceObject: Codable {
    let language, location, period, duration: String
    let developerExperienceDescription, technologies: String
    let projects: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case language, location, period, duration
        case developerExperienceDescription = "description"
        case technologies, projects
        case imageName = "image"
    }
}

// MARK: - Education
struct EducationObject: Codable {
    let school, course, location, period: String
    let graduationYear: String

    enum CodingKeys: String, CodingKey {
        case school, course, location, period
        case graduationYear = "graduation year"
    }
}

// MARK: - ExperienceOverview
struct ExperienceOverviewObject: Codable {
    let jobType, yearsExperience: String

    enum CodingKeys: String, CodingKey {
        case jobType = "job type"
        case yearsExperience = "years experience"
    }
}

// MARK: - FileInformation
struct FileInformationObject: Codable {
    let contentVersion, contentDate, fileFormatVersion: String

    enum CodingKeys: String, CodingKey {
        case contentVersion = "content version"
        case contentDate = "content date"
        case fileFormatVersion = "file format version"
    }
}

// MARK: - Hobby
struct HobbyObject: Codable {
    let hobby: String
}

// MARK: - Certification
struct CertificationObject: Codable {
    let certification, provider, location, attainmentYear: String

    enum CodingKeys: String, CodingKey {
        case certification, provider, location
        case attainmentYear = "attainment year"
    }
}

// MARK: - ProfessionalExperience
struct ProfessionalExperienceObject: Codable {
    let jobTitle, professionalExperienceDescription, company, companyDescription: String
    let companyWebsite: String
    let location, period, duration, accomplishments: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case jobTitle = "job title"
        case professionalExperienceDescription = "description"
        case company
        case companyDescription = "company description"
        case companyWebsite = "company website"
        case location, period, duration, accomplishments
        case imageName = "image"
    }
}

// MARK: - Profile
struct ProfileObject: Codable {
    let profession, general, valueProposition: String

    enum CodingKeys: String, CodingKey {
        case profession, general
        case valueProposition = "value proposition"
    }
}

// MARK: - Skill
struct SkillObject: Codable {
    let skill: String
}

// MARK: - SwiftCourse
struct SwiftCourseObject: Codable {
    let provider, course, location, period: String
    let duration, completionYear: String
    let projectsCompleted: String?

    enum CodingKeys: String, CodingKey {
        case provider, course, location, period, duration
        case completionYear = "completion year"
        case projectsCompleted = "projects completed"
    }
}

// MARK: - Website
struct WebsiteObject: Codable {
    let website: String
    let url, websiteURL: String?

    enum CodingKeys: String, CodingKey {
        case website, url
        case websiteURL = "url "
    }
}
