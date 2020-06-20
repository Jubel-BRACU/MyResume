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

        enum URLComponent {
            static let scheme = "https"
            static let host = "docs.google.com"
        }
        
        enum URLPath {
            static let uc = "/uc"
        }
        
        enum QueryParameter {
            static let export = (key: "export", value: "download")
            static let id = "id"
        }
        
        enum ResourceID {
            static let jsonFile = "1-Jr-fl2xvW6Alsimu_CE2ZDgZLY4aJfg"
            
//            static let jsonFile = ""
//                force download error for testing
        }
        
        case json
        case image(name: String)
        
        var url: URL?  {
            
            switch self {
            case .json:
                 var components = self.getURLComponents(appendingWith: URLPath.uc)
                 components.queryItems = [
                    URLQueryItem(name: QueryParameter.export.key, value: QueryParameter.export.value),
                    URLQueryItem(name: QueryParameter.id, value: ResourceID.jsonFile)
                 ]
                 
                 return components.url
                
            case .image(let image):
                return nil
            }
        }
        
        func getURLComponents(appendingWith path: String) -> URLComponents {
            var components = URLComponents()
            components.scheme = URLComponent.scheme
            components.host = URLComponent.host
            components.path = path
            return components
        }
    }
    
    
    //class initializer
    private init() {}
    
    
    //fetch json file from remote server
    private func dowloadRemoteJSON(completion: @escaping (URL?, Error?) -> Void) {
        guard let url = Endpoint.json.url else {
            fatalError("Error! Cannot fetch resume json data, url is missing.")
        }

        let downloadTask = URLSession.shared.downloadTask(with: url) { (fileURL, response, error) in

            guard let fileURL = fileURL else {
                completion(nil, error)
                return
            }

            if let error = error {
                print("Error! Could not fetch remote JSON file: \(error.localizedDescription)")
                completion(nil, error)
                return
            }

            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: false)

                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                completion(savedURL, nil)

            } catch {
                print ("JSON File save / move error: \(error)")
            }
        }

        downloadTask.resume()
    }
    
    
    //get local / saved url to downloaded json file and parse
    func getRemoteResume(completion: @escaping (ResumeObject?, Error?) -> Void) {
        
        dowloadRemoteJSON { (url, error) in

            if let error = error {
                print("Error! Failed to fetch JSON file from remote server: \(error.localizedDescription)")
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
                   print("Error! Resume object not created. Reason: \(error.localizedDescription)")
               }
            }
        }
    }
}
