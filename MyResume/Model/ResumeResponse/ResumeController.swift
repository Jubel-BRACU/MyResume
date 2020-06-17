//
//  ResumeController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/12/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation


class ResumeController {
    
    static let shared = ResumeController()
    
    private enum Endpoint {
            
        enum AbsoluteURL {
            static let jsonFile = "https://www.icloud.com/iclouddrive/0CZ9C7GFdjhsVUkT5hqWEr1OQ#ResumeData_v5-2"
            static let imagesFolder = ""
        }

        enum URLComponent {
            static let scheme = "https"
            static let host = "drive.google.com/drive"
        }
        
        enum URLPath {
            static let json = "/file/d/17Xpw-KiLkTO_AHy3GRJLiHfNOfYkULSZ/view?usp=sharing"
            static let images = "/folders/1DlQpyZQ3HI_HKDDy-h4ZtUzK0harSSga"
        }
        
        enum Resource {
            static let jsonFilename = "ResumeData_v5.json"
        }
    }
    
    
    private init() {}
    
    
    private func dowloadRemoteJSON(completion: @escaping (URL?, Error?) -> Void) {
        guard let url = URL(string: Endpoint.AbsoluteURL.jsonFile) else {
            fatalError("Error! Cannot fetch resume json data, url is missing")
        }
        
        let task = URLSession.shared.downloadTask(with: url) { (localURL, urlResponse, error) in
            if let error = error {
                completion(nil, error)
            }
            
            //if download succesful
            if let localURL = localURL {
                completion(localURL, nil)
            }
        }

        task.resume()
    }
    
    
    //json file on remote server
    func getRemoteResume(completion: @escaping (ResumeObject?, Error?) -> Void) {
       
        dowloadRemoteJSON { (url, error) in
            
            if let error = error {
                print("Error! Failed to fetch JSON file from remote server.")
                completion(nil, error)
            }

            if let url = url {
                
                do {
                    
                    let data = try Data(contentsOf: url)
                    let json = JSONDecoder()
                    let response = try json.decode(ResumeResponse.self, from: data)

                    completion(response.resume, nil)

               } catch {
                   completion(nil, error)
                   print("Error! Resume object not created. Reason: \(error.localizedDescription)\n")
               }
            }
        }
    }
    
    
    //local json file
    func getLocalResume(completion: @escaping (ResumeObject?, Error?) -> Void) {
        let directory = "JSON Data"
        let suffix = "_v5-2.json"
        
        //get json file name
        let filename = locadLocalJSON(directory: directory, type: suffix)
        
        let path = Bundle.main.path(forResource: filename, ofType: nil)
        guard path != nil else {
            print("Error! .json file not found.\n")
            return
        }
        
        do {
            let url = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: url)
            let json = JSONDecoder()
            let response = try json.decode(ResumeResponse.self, from: data)
            print("Success! Resume loaded from local file system.")

            completion(response.resume, nil)
            
        } catch {
            completion(nil, error)
            print("Error! Resume object not created. Reason: \(error.localizedDescription)\n")
        }
    }
        
        
    //get json data file name
    private func locadLocalJSON(directory: String, type: String) -> String {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var filename = ""
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasSuffix(type) {
                    print("Success! .json file found: \(item)\n")
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
