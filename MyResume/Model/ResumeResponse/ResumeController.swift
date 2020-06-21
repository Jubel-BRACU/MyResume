//
//  ResumeController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/12/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit


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
            static let logos: [String: String] = [
                "waitersFriend": "1zeHw5mxhw0r5Oo2BMIe2NIPeIO8YJhEx",
                "swift": "1bJnvQMUvaYGV1FYiVg17ArwSnlI6bP1h",
                "sandp": "1o8DFULZ0aVFhSPqPuH6kqfLonYJpRF68",
                "profile_image": "17iMiep8uVa7vy9LjTXXSRUZFDB9qPY0_",
                "myResume": "1l37c_mdg_0ghV2CUPjP-yp-KL_jajeSn",
                "hrg": "19WzfvYj_KIsyhGgwjI2Uya9bL9D3k4zy",
                "fairfax": "1sXzJn8DMe8fAqJ9lPyl0HA2E5TZkWR9t",
                "estee": "1NZg_QWdJoTnp_5jNDdK1TXGgRT8cW5fV",
                "airstayz": "1NZg_QWdJoTnp_5jNDdK1TXGgRT8cW5fV",
                "7marbles": "19K0LiXE2a2ZMSpE_JsBQue4aK4MzJEm_"
            ]
            
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
                
            case .image(let name):
                var components = self.getURLComponents(appendingWith: URLPath.uc)
                components.queryItems = [
                   URLQueryItem(name: QueryParameter.export.key, value: QueryParameter.export.value),
                   URLQueryItem(name: QueryParameter.id, value: ResourceID.logos[name])
                ]
                
                return components.url
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
    
}


//MARK - Network Request Handlers
    
extension ResumeController {
    
    //get local / saved url to downloaded json file and parse
    func getRemoteResume(completion: @escaping (ResumeObject?, Error?) -> Void) {
        
        downloadRemoteJSON { (url, error) in

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
    
    
    //fetch json file from remote server
    private func downloadRemoteJSON(completion: @escaping (URL?, Error?) -> Void) {
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
    
    
    func getRemoteLogo(for name: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = Endpoint.image(name: name).url else {
//            print("URL for image request: \(url)")
            return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            //check for error
            if let error = error {
                print("Error fetching image: \(error.localizedDescription) ")
                
                completion(nil, error)
                return
            }

            //check for server response code 200, else bail out
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, error)
                return
            }

            if let data = data {
                guard let image = UIImage(data: data) else {
                    completion(nil,error)
                    return
                }
                
                //save image to core data
//                self.updateCoreData(image: photo, with: data)
                
                //pass image back to caller
                completion(image, nil)
            }
        }

        task.resume()
    }
}
