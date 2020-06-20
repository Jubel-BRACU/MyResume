//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

//MARK: - Global / Common collectionView properties

let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier


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
        configureVC()
    }
    
    
    //MARK: - UI / Configuration
    
    private func configureVC() {
        segmentedControl.selectedSegmentIndex = SegmentControl.experience.rawValue
    }
    
    
    func updateProfileSection() {
        guard let resume = ResumeViewController.resume else { return }
        
        DispatchQueue.main.async {
            self.profilePictureImageView.setProperties(borderWidth: self.borderWidth, borderColor: self.borderColor, cornerRadius: nil)
            self.profilePictureImageView.makeCircle()
            self.setContactInfoLabels(resume: resume, labels: self.contactInformationLabels)
            self.setWebsiteLabels(resume: resume, labels: self.websiteLabels)
            self.setProfileInfo(resume: resume, label: self.professionLabel, textViews: nil)
        }
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
    
    
   private func updateUI() {
        self.updateProfileSection()
    }
    

    private func fetchLocalResume() {
        ResumeController.shared.getLocalResume { [unowned self] (resume, error) in
            guard let _ = resume else {
                //TODO: trigger error alert
                
                return
            }
            
            if let resume = resume {
                ResumeViewController.resume = resume
                self.updateUI()
            }
            
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
