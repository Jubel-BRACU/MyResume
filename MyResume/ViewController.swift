//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, ResumeDelegate {
    
    //MARK: - Custom Protocols
    //protocol method to receive json data once loaded
    func jsonDataLoaded(_ data: Resume, _ filename: String) {
        resume = data
        jsonFilename = filename
        //      print("Success! Delegate / Protocol pattern is working.\n")
    }
    
    //MARK: - UI Outlets
    //IB Properties
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet var contactInformationLabels: [UILabel]!
    @IBOutlet var websiteLabels: [UILabel]!
    
    //IB Programmatic properties
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var borderColor: UIColor = .gray
    @IBInspectable var cornerRadius: CGFloat = 0
    
    
    //Website Labels Gesture Recognizers
    @IBAction func linkedinLabelTapped(_ sender: Any) {
        let url = "https://www.linkedin.com/in/simonitalia/"
        self.loadWebsite(url: url)
    }
    
    @IBAction func githubLabelTapped(_ sender: Any) {
        let url = "https://github.com/simonitalia"
        self.loadWebsite(url: url)
    }
    
    @IBAction func emailLabelTapped(_ sender: Any) {
        let recipients = ["simonitalia@gmail.com"]
        self.loadMailComposer(to: recipients)
    }
    
    @IBAction func phoneLabelTapped(_ sender: Any) {
        let number = "TEL://+16463790039"
        callNumber(number: number)
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
    //fetch json data
    func fetchData() {
        ResumeController.shared.loadJSONData { [unowned self] (success) in
            guard success != nil else { return }
            self.updateUI()
        }
    }
    
    //View UI handler
    func updateUI() {
        
        //set contact information labels
        resume?.setContactInfoLabels(resume: resume, labels: contactInformationLabels)
        
        //set website links labels
        resume?.setWebsiteLabels(resume: resume, labels: websiteLabels)
        
        //set profile image view properties
        profilePictureImageView.setViewProperties(borderWidth: borderWidth, borderColor: borderColor)
        
        //set view shape
        profilePictureImageView.makeViewCircle()
    }
    



