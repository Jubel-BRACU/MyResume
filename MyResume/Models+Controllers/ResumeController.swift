//
//  ResumeController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/12/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation

class ResumeController {
    
    //set to static so this class can be used by any VC without instantiating
    static let shared = ResumeController()
    var delegate: ResumeDelegate?
    
    //load data from local JSON file
    func loadJSONData(completion: @escaping (_ success: Bool?) -> Void) {
        
        let directory = "Source Data"
        let suffix = ".json"
        
        //get json file name
        let filename = getJSONFileName(directory: directory, type: suffix)
        
        let path = Bundle.main.path(forResource: filename, ofType: nil)
        guard path != nil else {
            print("Error! .json file not found.\n")
            return
        }
        
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let json = JSONDecoder()
            let resume = try json.decode(Resume.self, from: data)
            //             print("Success! Resumes objects loaded:\n \(resume)")
            
            //pass resume data to VC
            delegate?.jsonDataLoaded(resume, filename)
            completion(true)
            
        } catch {
            completion(nil)
            print("Error! Resume object not created. Reason: \(error.localizedDescription)\n")
        }
    }
    
    //get json data file name
    func getJSONFileName(directory: String, type: String) -> String {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var filename = ""
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasSuffix(type) {
                    //                    print("Success! .json file found: \(item)\n")
                    filename = item
                }
            }
            
        } catch {
            let error = "Error! json filename not found. Reason: \(error.localizedDescription)\n"
            print(error)
            return error
        }
        
        return filename
    }
}
