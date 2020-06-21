//
//  iOSProjectsCollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/22/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit


fileprivate let cellReuseIdentifier = "iOSProjectCell"
fileprivate let reusableCellNibName = cellReuseIdentifier


class iOSProjectsViewController: UIViewController {
    
    //MARK: - Storyboard Connections

    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Class Properties
    
    enum ProjectSection: Int {
        case personal = 0, coursework
    }
    
    lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            switch ProjectSection(rawValue: sectionIndex) {
            case .personal:
                return self?.setupExperienceAndProjectsLayout()

            case .coursework:
                return self?.setupExperienceAndProjectsLayout()

            default:
                fatalError("Should not be none")
            }

        }

        return layout
    }()
    
    
    private var resume: ResumeObject? {
        ResumeViewController.shared.resume
    }
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollecionView()
    }
    
    
    //MARK: - Configuration
    
    private func configureCollecionView() {
        ResumeViewController.shared.iosProjectsDelegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //custom cell and xib file registrations
        collectionView.register(UINib(nibName: sectionHeaderReusableViewNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)
        collectionView.register(UINib(nibName: reusableCellNibName, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)

        //Setup compositional layout
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
    }
}


// MARK: - UICollectionViewDataSource
    
extension iOSProjectsViewController: UICollectionViewDataSource {

    //set number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //set header text for eeach section
            switch ProjectSection(rawValue: indexPath.section) {
                
            //section 0
            case .personal:
                let headerText = "Personal Projects"
                sectionHeaderView.setLabelTextWith(string: headerText)
              
            //section 1
            case .coursework:
                let headerText = "Select Coursework Projects"
             sectionHeaderView.setLabelTextWith(string: headerText)
            
            case .none:
                fatalError("Error! Unknown case, failed to set header section")
            }
        }
        
        return sectionHeaderView
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resume = resume else { return 0 }
        
        switch ProjectSection(rawValue: section) {
        
        //section 0
        case .personal:
            let count = resume.personalProjects.count
            return count
         
        //section 1
        case .coursework:
            let count = resume.courseworkProjects.count
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let resume = resume else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! iOSProjectCell
        
        //set cell data object
        switch ProjectSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .personal:
            let projects = resume.personalProjects[indexPath.item]
            cell.setLabelsText(using: projects.projectName, for: 0)
            cell.setLabelsText(using: projects.date, for: 1)
            cell.setLabelsText(using: projects.projectDescription, for: 2)
            cell.setLabelsText(using: projects.github, for: 3)
            cell.setLabelsText(using: projects.technologies, for: 4)
            return cell
            
        //section 1 cell
        case .coursework:
            let projects = resume.courseworkProjects[indexPath.item]
            cell.setLabelsText(using: projects.projectName, for: 0)
            cell.setLabelsText(using: projects.date, for: 1)
            cell.setLabelsText(using: projects.projectDescription, for: 2)
            cell.setLabelsText(using: projects.github, for: 3)
            cell.setLabelsText(using: projects.technologies, for: 4)
            return cell

        default:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }
}

// MARK:- UICollectionViewDelegate

extension iOSProjectsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let resume = resume else { fatalError("Resume object should not be nil") }

        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        switch ProjectSection(rawValue: indexPath.section) {
        
        case .personal:
            let item = resume.personalProjects[indexPath.item]
            vc.viewTitle = item.projectName
            vc.viewDescription = item.projectDescription
            vc.viewDetails = item.technologies
            vc.viewImage = item.imageName

        case .coursework:
            let item = resume.courseworkProjects[indexPath.item]
            vc.viewTitle = item.projectName
            vc.viewDescription = item.projectDescription
            vc.viewDetails = item.technologies
               
        case .none:
               fatalError("Error! Unknown case, failed to set destinaton VC properties")
           }

        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - ResumeViewController Delegate

extension iOSProjectsViewController: ResumeViewControllerDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
