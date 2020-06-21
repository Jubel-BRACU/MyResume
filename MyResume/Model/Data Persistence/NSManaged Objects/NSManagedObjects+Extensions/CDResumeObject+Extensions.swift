//
//  Resume+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 6/16/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation
import CoreData


extension CDResume {
    
    class func createCDResumeObject(with resume: ResumeObject, in context: NSManagedObjectContext) throws -> CDResume {
        
        //create core data resume object in context
        let cdResume = CDResume(context: context)
        
        //encode resume as data
        do {
            let data = try JSONEncoder().encode(resume)
            cdResume.resumeObject = data
            print("Success! Created core data Resume object")
            return cdResume
            
        } catch {
            throw error
        }
    }
}
