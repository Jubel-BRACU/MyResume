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
    func jsonDataLoaded(_ data: Resume?, _ filename: String?) {
    //      print("Success! Delegate / Protocol pattern is working.\n")
        ViewController.resume = data
        jsonFilename = filename
    }
    
    //MARK: - UI Outlets
    //IB Properties
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet var contactInformationLabels: [UILabel]!
    @IBOutlet var websiteLabels: [UILabel]!
    
    //Segment Control
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        //show relevant container views, hide other container views
        showContainerView(forSegment: segmentedControl.selectedSegmentIndex)
    }
    
    //Container Views
    @IBOutlet var containerViews: [UIView]!
    
    //IB Programmatic properties
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var borderColor: UIColor = .darkGray
    @IBInspectable var cornerRadius: CGFloat = 0
    
    //website labels gesture recognizers
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
    static var resume: Resume? = nil
    var jsonFilename: String?
    
    //MARK: - Built-in UIView methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //set VC to delegate to respond when json data is loaded
        ResumeController.shared.delegate = self
        
        //fire load of json data file
        fetchData()
        
        //Initial UI setup on view load
        setupInitialUI()
 
    }
    
    //MARK: - Custom methods
    func setupInitialUI() {
        
        //Set segmented control to default
        segmentedControl.selectedSegmentIndex = SegmentControl.experience.rawValue
        
        //hide all other containers
        showContainerView(forSegment: SegmentControl.experience.rawValue)
    }
    
    //handle display of conatiner views
    func showContainerView(forSegment tag: Int) {
        
        for container in containerViews {
            
            //show container
            if container.tag == tag {
                container.alpha = 1
                container.isHidden = false
            
            //hide container
            } else {
                container.alpha = 0
                container.isHidden = true
            }
        }
    }
    
    //fetch json data
    func fetchData() {
        ResumeController.shared.loadJSONData { [unowned self] (success) in
            guard success != nil else { return }
            self.updateUI()
        }
    }
    
    //view UI handler
    func updateUI() {
        
        //set profile image view properties
        profilePictureImageView.setProperties(borderWidth: borderWidth, borderColor: borderColor, cornerRadius: nil)
        
        //set view shape
        profilePictureImageView.makeCircle()
        
        //set contact information labels
        setContactInfoLabels(resume: ViewController.resume, labels: contactInformationLabels)
        
        //set website links labels
        setWebsiteLabels(resume: ViewController.resume, labels: websiteLabels)
        
        //set profile info (profession, about section)
        setProfileInfo(resume: ViewController.resume, label: professionLabel, textViews: nil)
    }
}
