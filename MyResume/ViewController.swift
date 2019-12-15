//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ResumeDelegate {
    
    //MARK: - Custom Protocols
    
    //protocol method to receive json data once loaded
        func jsonDataLoaded(_ data: Resume, _ filename: String) {
            resume = data
            jsonFilename = filename
//      print("Success! Delegate / Protocol pattern is working.\n")
        }
    
    //MARK: - UI Outlets
    @IBOutlet var contactInformationLabels: [UILabel]!
    @IBOutlet var websiteLabels: [UILabel]!
    
    //Website Labels Gesture Recognizers
    @IBAction func linkedinLabelTapped(_ sender: Any) {
        self.loadWebsite(url: "https://www.linkedin.com/in/simonitalia/")
    }
    
    @IBAction func githubLabelTapped(_ sender: Any) {
        self.loadWebsite(url: "https://github.com/simonitalia")
    }
    
    
    //MARK: - Custom Properties
    //properties
    var resume: Resume?
    var jsonFilename: String?
    
    //MARK: - Managed UIView methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set VC to delegate to respond when json data is loaded
        ResumeController.shared.delegate = self
        
        //fire load of json data file
        fetchData()
    }
    
    //MARK: - Custom methods
    
    //View UI handler
    func updateUI() {
        
        //set contact information labels
        resume?.setContactInfoLabels(resume: resume, labels: contactInformationLabels)
        
        //set website links labels
        resume?.setWebsiteLabels(resume: resume, labels: websiteLabels)
    }
    
    func fetchData() {
        ResumeController.shared.loadJSONData { (success) in
            guard success != nil else { return }
            self.updateUI()
        }
    }
    
}

