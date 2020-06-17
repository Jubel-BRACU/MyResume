//
//  Resume+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 6/16/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation
import CoreData


//extension CDResume {
//    class func createResume(for resume: Resume, in context: NSManagedObjectContext)  -> CDResume? {
//        
//        let managedObject = CDResume(context: context)
//        managedObject.id = UUID().uuidString
//        managedObject.date = resume.date
//        managedObject.version = resume.version
//        
//        managedObject.contactInformation = ContactInformation.createContactInformation(from: resume, in: context)
//            
//        managedObject.profile = Profile.createProfile(from: resume, in: context)
//        
//        Website.createWebsites(from: resume, in: context)
//        
//        managedObject.personalProjects = resume.personalProjects
//        
//        managedObject.courseworkProjects = resume.courseworkProjects
//        
//        managedObject.professionalExp = resume.professionalExperience
//        
//        managedObject.developerExp = resume.developerExperience
//        
//        managedObject.experienceOverview = resume.experienceOverview
//        
//        managedObject.skills = resume.skills
//            
//        managedObject.education = resume.education
//        
//        managedObject.industryCertifications = resume
//        
//        managedObject.projectBasedCourses
//        
//        managedObject.foundationalCourses
//        
//        managedObject.otherCertifications
//        
//        managedObject.hobbies
//        
//        
//        return managedObject
//    }
//
//    class func deleteResume() {
//    
//    }
//}
//
//extension ContactInformation {
//    class func createContactInformation(from resume: Resume, in context: NSManagedObjectContext)  -> ContactInformation? {
//        let managedObject = ContactInformation(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension Profile {
//   class func createProfile(from resume: Resume, in context: NSManagedObjectContext)  -> Profile? {
//        let managedObject = Profile(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension Website {
//    class func createWebsites(from resume: Resume, in context: NSManagedObjectContext) {
//        return NSSet(array: resume.websites)
//    }
//    
//    
//}
//
//
//extension ProfessionalExp {
//    class func professionalExp(from resume: Resume, in context: NSManagedObjectContext)  -> ProfessionalExp? {
//        let managedObject = ProfessionalExp(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension PersonalProject {
//    class func createPersonalProject(from resume: Resume, in context: NSManagedObjectContext)  -> PersonalProject? {
//        let managedObject = PersonalProject(context: context)
//        return managedObject
//    }
//}
//
//
//extension CourseworkProject {
//    class func createCourseWorkProject(from resume: Resume, in context: NSManagedObjectContext)  -> CourseworkProject? {
//        let managedObject = CourseworkProject(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension ProfessionalExp {
//    class func createProfessionalExperience(from resume: Resume, in context: NSManagedObjectContext)  -> ProfessionalExp? {
//        let managedObject = ProfessionalExp(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension DeveloperExp {
//    class func createDeveloperlProject(from resume: Resume, in context: NSManagedObjectContext)  -> DeveloperExp? {
//        let managedObject = DeveloperExp(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension ExperienceOverview {
//    class func createExperienceOverview(from resume: Resume, in context: NSManagedObjectContext)  -> ExperienceOverview? {
//        let managedObject = ExperienceOverview(context: context)
//        
//        return managedObject
//    }
//}
//    
//
//extension Skill {
//    
//    class func createSkill(from resume: Resume, in context: NSManagedObjectContext)  -> Skill? {
//        let managedObject = Skill(context: context)
//        
//        return managedObject
//    }
//}
//    
//    
//extension Education {
//    class func createEducation(from resume: Resume, in context: NSManagedObjectContext)  -> Education? {
//        let managedObject = Education(context: context)
//        
//        return managedObject
//    }
//}
//    
//    
//extension IndustryCertification {
//    class func createIndustryCertification(from resume: Resume, in context: NSManagedObjectContext)  -> IndustryCertification? {
//        let managedObject = IndustryCertification(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension ProjectBasedCourse {
//    class func createProjectBasedCourse(from resume: Resume, in context: NSManagedObjectContext)  -> ProjectBasedCourse? {
//        let managedObject = ProjectBasedCourse(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension FoundationalCourse {
//    class func createFoundationalCourse(from resume: Resume, in context: NSManagedObjectContext)  -> FoundationalCourse? {
//        let managedObject = FoundationalCourse(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension OtherCertification {
//    class func createOtherCertification(from resume: Resume, in context: NSManagedObjectContext)  -> OtherCertification? {
//        let managedObject = OtherCertification(context: context)
//        
//        return managedObject
//    }
//}
//
//
//extension Hobby {
//    class func createHobby(from resume: Resume, in context: NSManagedObjectContext)  -> Hobby? {
//        let managedObject = Hobby(context: context)
//        
//        return managedObject
//    }
//}
