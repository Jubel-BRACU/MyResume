//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit


@IBDesignable
class ViewController: UIViewController {
    
    //MARK: - Storyboard connections
    
    //outlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet var contactInformationLabels: [UILabel]!
    @IBOutlet var websiteLabels: [UILabel]!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var containerViews: [UIView]!
     
    
    //inspectables
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var borderColor: UIColor = .darkGray
    @IBInspectable var cornerRadius: CGFloat = 0
    
    
    //actions
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        //show relevant container views, hide other container views
        showContainerView(forSegment: segmentedControl.selectedSegmentIndex)
    }
    
    
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
    
    
    //MARK: - Class Properties
    
    static var resume: Resume? = nil
    private var jsonFilename: String?
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResumeController.shared.delegate = self //set resume delegate
        fetchData()
        setupInitialUI()
    }
    
    
    //MARK: - Custom methods
    
    private func setupInitialUI() {
        segmentedControl.selectedSegmentIndex = SegmentControl.experience.rawValue
        showContainerView(forSegment: SegmentControl.experience.rawValue)
    }
    
    
    //handle display of conatiner views
    private func showContainerView(forSegment tag: Int) {
        
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
    
    
    private func fetchData() {
        ResumeController.shared.loadJSONData { [unowned self] (success) in
            guard success != nil else { return }
            self.updateUI()
        }
    }
    
    
    private func updateUI() {
        profilePictureImageView.setProperties(borderWidth: borderWidth, borderColor: borderColor, cornerRadius: nil)
        profilePictureImageView.makeCircle()
        setContactInfoLabels(resume: ViewController.resume, labels: contactInformationLabels)
        setWebsiteLabels(resume: ViewController.resume, labels: websiteLabels)
        setProfileInfo(resume: ViewController.resume, label: professionLabel, textViews: nil)
    }
}


//MARK: - Resume Delegate

extension ViewController: ResumeDelegate {
    func jsonDataLoaded(_ data: Resume?, _ filename: String?) {
//      print("Success! Delegate / Protocol pattern is working.\n")
        ViewController.resume = data
        jsonFilename = filename
    }
}
