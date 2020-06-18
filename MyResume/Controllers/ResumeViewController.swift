//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit


@IBDesignable
class ResumeViewController: UIViewController {
    
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
    
    static var resume: ResumeObject?
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocalResume()
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
    
    
    private func fetchLocalResume() {
        ResumeController.shared.getLocalResume { [unowned self] (resume, error) in
            guard let _ = resume else {
                //TODO: trigger fetch file from remote server
                return
            }
            
            if let resume = resume {
                ResumeViewController.resume = resume
            }
            
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            self.updateUI()
        }
    }
    
    
    private func updateUI() {
        guard let resume = ResumeViewController.resume else { return }
        
        profilePictureImageView.setProperties(borderWidth: borderWidth, borderColor: borderColor, cornerRadius: nil)
        profilePictureImageView.makeCircle()
        setContactInfoLabels(resume: resume, labels: contactInformationLabels)
        setWebsiteLabels(resume: resume, labels: websiteLabels)
        setProfileInfo(resume: resume, label: professionLabel, textViews: nil)
    }
}
