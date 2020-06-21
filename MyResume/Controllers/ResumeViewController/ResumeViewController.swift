//
//  ViewController.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/9/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit
import CoreData

//MARK: - ResumeViewController Protocol

protocol ResumeViewControllerDelegate {
    func reloadCollectionView()
}


//MARK: - Global / Common collectionView properties

let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier


@IBDesignable
class ResumeViewController: UIViewController {
    
    //MARK: - Core Data
    
    private var container: NSPersistentContainer? = {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }()
    
    var fetchedResultsController: NSFetchedResultsController<CDResume>?
    
    
    //MARK: - Storyboard connections

    //outlets
    @IBOutlet weak var resumeActivityIndicator: UIActivityIndicatorView!
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
    
    enum SegmentControl: Int {
        case experience = 0, projects, education, training
    }
    
    
    enum WebsiteLabel: Int {
        case linkedin = 0, github, website
    }
    
    
    enum ContactLabel: Int {
        case name = 0, phone, email
    }

    enum ProfileTextViews: Int {
        case general = 0, valueProposition
    }
    
    static let shared = ResumeViewController()
    var resume: ResumeObject?
    
    //delegates for containers
    var experienceDelegate: ResumeViewControllerDelegate?
    var iosProjectsDelegate: ResumeViewControllerDelegate?
    var educationDelegate: ResumeViewControllerDelegate?
    var trainingDelegate: ResumeViewControllerDelegate?

    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResumeFromCoreData()
        configureVC()
    }
    
    
    //MARK: - UI / Configuration
    
    private func configureVC() {
        segmentedControl.selectedSegmentIndex = SegmentControl.experience.rawValue
    }
    
    
    func updateProfileSection() {
        guard let resume = ResumeViewController.shared.resume else { return }
        
        DispatchQueue.main.async {
            
            //profile image item
            self.profilePictureImageView.setProperties(borderWidth: self.borderWidth, borderColor: self.borderColor, cornerRadius: nil)
            self.profilePictureImageView.makeCircle()
            self.profilePictureImageView.image = UIImage(named: "profile_image")
            
            //other items
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
    
    
    private func showActivityIndicator(_ flag: Bool) {
        DispatchQueue.main.async {
            self.resumeActivityIndicator.isHidden = !flag
            flag ? self.resumeActivityIndicator.startAnimating() : self.resumeActivityIndicator.stopAnimating()
            flag ? self.view.bringSubviewToFront(self.resumeActivityIndicator) : self.view.sendSubviewToBack(self.resumeActivityIndicator)
        }
    }
    
    
    internal func updateUI(with resume: ResumeObject) {
        ResumeViewController.shared.resume = resume
        updateProfileSection()
        updateContainerViewControllers()
    }
    
    
    private func updateContainerViewControllers() {
        ResumeViewController.shared.experienceDelegate?.reloadCollectionView()
        ResumeViewController.shared.iosProjectsDelegate?.reloadCollectionView()
        ResumeViewController.shared.educationDelegate?.reloadCollectionView()
        ResumeViewController.shared.trainingDelegate?.reloadCollectionView()
    }


    private func fetchRemoteResume() {
        showActivityIndicator(true)
        
        ResumeController.shared.getRemoteResume { [unowned self] (resume, error) in
            self.showActivityIndicator(false)
            
            if let resume = resume {
                self.updateUI(with: resume)
            }
       
            if let error = error {
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "Resume Download Error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    }
}

//MARK: - Core Data

extension ResumeViewController: NSFetchedResultsControllerDelegate {
    
    func fetchResumeFromCoreData() {
        guard let context = container?.viewContext else {
            print("Error! Cannot update core data, container is missing.")
            return
        }
        
        let fetchRequest:NSFetchRequest<CDResume> = CDResume.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "resumeObject", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        //fetch resume from core data
        do {
            try fetchedResultsController?.performFetch()
            
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
            
        //handle fetch result
        guard let objects = fetchedResultsController?.fetchedObjects, !objects.isEmpty else {
            
            //fetch data from remote
            print("No fetched objects returned from core data, fetching resume from remote server...")
            fetchRemoteResume()
            return
        }
                
        //convert object to resume
        if let data = objects.first?.resumeObject {
        
            do {
                let resume = try JSONDecoder().decode(ResumeObject.self, from: data)
                print("Success! Resume object fetched and decoded from core data.")
                
                //update properties and UI
                ResumeViewController.shared.resume = resume
                updateProfileSection()
                updateContainerViewControllers()
    
            } catch {
                print("Error! Could not fetch objects from core data: \(error.localizedDescription)")
            }
        }
    }
}
