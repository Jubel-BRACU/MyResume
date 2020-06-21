//
//  ResumeDataViewController.swift
//  MyResume
//
//  Created by Simon Italia on 6/21/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit
import CoreData

class ResumeDataViewController: ResumeViewController {
    
    //MARK: - Core Data
    private var container: NSPersistentContainer? = {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }()
    
    
    override func updateUI(with resume: ResumeObject) {
        super.updateUI(with: resume)
        updateCoreData(with: resume)
    }
    
    
    private func updateCoreData(with resume: ResumeObject) {
        print("updateCoreData(with: ) method called")
        
        guard let context = container?.viewContext else {
            print("Error! Cannot update core data, container is missing.")
            return
        }
        
        do {
            //create core data context with resume
            _ = try CDResume.createCDResumeObject(with: resume, in: context)
            
            do {
                //save context
                try context.save()
                
            } catch {
                print("Error! Could not save resume object to core data: \(error.localizedDescription)")
            }
            
        } catch {
            print("Error! Could not create core data resume object: \(error.localizedDescription)")
        }
    }
}
