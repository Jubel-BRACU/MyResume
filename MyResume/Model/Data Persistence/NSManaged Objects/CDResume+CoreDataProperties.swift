//
//  CDResume+CoreDataProperties.swift
//  MyResume
//
//  Created by Simon Italia on 6/21/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension CDResume {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDResume> {
        return NSFetchRequest<CDResume>(entityName: "Resume")
    }

    @NSManaged public var resumeObject: Data?

}
