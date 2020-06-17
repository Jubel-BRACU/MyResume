//
//  iOSProjectsCollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/22/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit


private let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
private let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier
private let cellReuseIdentifier = "iOSProjectCell"
private let reusableCellNibName = cellReuseIdentifier


class iOSProjectsCollectionViewController: UICollectionViewController {
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch ProjectSection(rawValue: sectionIndex) {
            case .personal:
                return self?.setupLayoutOne()
                
            case .coursework:
                return self?.setupLayoutOne()
                
            case .none:
                fatalError("Should not be none")
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
    
extension iOSProjectsCollectionViewController {

    //set number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //set header text for eeach section
            switch ProjectSection(rawValue: indexPath.section) {
                
            //section 0
            case .personal:
                let headerText = "Personal Projects"
                sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .coursework:
                let headerText = "Select Coursework Projects"
             sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
            
            case .none:
                fatalError("Error! Unknown case, failed to set header section")
            }
        }
        
        return sectionHeaderView
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resume = resume else { return 0 }
        
        switch ProjectSection(rawValue: section) {
        
        //section 0
        case .personal:
            let count = resume.personalProjects.count
            
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .coursework:
            let count = resume.courseworkProjects.count
            print("Number of items for section \(section): \(count)\n")
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
//            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .coursework:
            let projects = resume.courseworkProjects[indexPath.item]
            cell.setLabelsText(using: projects.projectName, for: 0)
            cell.setLabelsText(using: projects.date, for: 1)
            cell.setLabelsText(using: projects.projectDescription, for: 2)
            cell.setLabelsText(using: projects.github, for: 3)
            cell.setLabelsText(using: projects.technologies, for: 4)
//            print("Cell for section \(indexPath.section) set")
            return cell

        default:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }
}

// MARK:- UICollectionViewDelegate

extension iOSProjectsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let resume = resume else { fatalError("Resume object should not be nil") }

        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        switch ProjectSection(rawValue: indexPath.section) {
        
        case .personal:
            let item = resume.personalProjects[indexPath.item]
            vc.viewTitle = item.projectName
            vc.viewDescription = item.projectDescription
            vc.viewDetails = item.technologies
            vc.viewImage = item.image

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
