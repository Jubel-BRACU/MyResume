//
//  CollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

private let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
private let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier
private let cellReuseIdentifier = "ExperienceCell"
private let reusableCellNibName = cellReuseIdentifier


class ExperienceCollectionViewController: UICollectionViewController {
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch ExperienceSection(rawValue: sectionIndex) {
            case .professional:
                return self?.setupLayoutOne()
                
            case .developer:
                return self?.setupLayoutTwo()
                
            case .none:
                fatalError("Should not be none ")
            }
        }
        return layout
    }()
    
    
    var resume: ResumeObject? {
        ResumeViewController.resume
    }
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollecionView()
    }
    
    
    private func configureCollecionView() {
        
        //custom cell and xib file registrations
        collectionView.register(UINib(nibName: sectionHeaderReusableViewNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)
        collectionView.register(UINib(nibName: reusableCellNibName, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        //Setup compositional layout
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
    }
}

    
// MARK: - UICollectionViewDataSource
extension ExperienceCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Section set")
        return 2
    }
    

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            switch ExperienceSection(rawValue: indexPath.section) {
                
            //section 0
            case .professional:
                let headerText = "Professional Experience"
                sectionHeaderView.setLabelTextWith(string: headerText)
//                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .developer:
                let headerText = "Developer Experience"
             sectionHeaderView.setLabelTextWith(string: headerText)
//                print("Header set for section: \(indexPath.section)")
            
            case .none:
                fatalError("Error! Unknown case, failed to create section header")
            }
        }

        return sectionHeaderView
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resume = resume else { return 0 }
        
        switch ExperienceSection(rawValue: section) {
        
        //section 0
        case .professional:
            let count = resume.professionalExperience.count
//            print("Number of items for section \(section): \(count)")
            return count
         
        //section 1
        case .developer:
            let count = resume.developerExperience.count
//            print("Number of items for section \(section): \(count)")
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let resume = resume else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ExperienceCell
        
        //set cell data object
        switch ExperienceSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .professional:
            let experience = resume.professionalExperience[indexPath.item]
            cell.setLabelsText(using: experience.company, for: 0)
            cell.setLabelsText(using: experience.location, for: 1)
            cell.setLabelsText(using: experience.period, for: 2)
            cell.setLabelsText(using: experience.jobTitle, for: 3)
            cell.setLabelsText(using: experience.professionalExperienceDescription, for: 4)

            let image = UIImage(systemName: "briefcase.fill")
            cell.setImage(with: image!)
//            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .developer:
            let experience = resume.developerExperience[indexPath.item]
            cell.setLabelsText(using: experience.language, for: 0)
            cell.setLabelsText(using: experience.location, for: 1)
            cell.setLabelsText(using: experience.period, for: 2)
            cell.setLabelsText(using: experience.projects, for: 3)
            cell.setLabelsText(using: experience.developerExperienceDescription, for: 4)
            
            let image = UIImage(systemName: "globe")
            cell.setImage(with: image!)
//            print("Cell for section \(indexPath.section) set")
            return cell

        case .none:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }
}
 

// MARK: - UICollectionViewDelegate

extension ExperienceCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let resume = resume else { fatalError("Resume object should not be nil") }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        switch ExperienceSection(rawValue: indexPath.section) {
            
        case .professional:
            let item = resume.professionalExperience[indexPath.item]
            vc.viewTitle = item.jobTitle
            vc.viewDescription = item.professionalExperienceDescription
            vc.viewDetails = item.accomplishments
            vc.viewImage = item.image
            
        case .developer:
            let item = resume.developerExperience[indexPath.item]
            vc.viewTitle = item.language
            vc.viewDescription = item.developerExperienceDescription
            vc.viewDetails = item.technologies
            vc.viewImage = item.image
               
        case .none:
            fatalError("Error! Unknown case, failed to set destination VC properties")
       }
         
        //display DetailVC
        self.present(vc, animated: true, completion: nil)
    }
}
