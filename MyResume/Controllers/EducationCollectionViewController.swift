//
//  EducationCollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/22/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

private let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
private let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier
private let cellReuseIdentifier = "EducationCell"
private let reusableCellNibName = cellReuseIdentifier


class EducationCollectionViewController: UICollectionViewController {

    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch EducationSection(rawValue: sectionIndex) {
            case .university:
                return self?.setupLayoutOne()
                
            case .certifications:
                return self?.setupLayoutOne()
                
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


// MARK: UICollectionViewDataSource

extension EducationCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //instantiate SectionHeaderCollectionReusableView
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //set header text for eeach section
            switch EducationSection(rawValue: indexPath.section) {
                
            //section 0
            case .university:
                let headerText = "University"
                sectionHeaderView.setLabelTextWith(string: headerText)
//                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .certifications:
                let headerText = "Industry Certifications"
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
        
        switch EducationSection(rawValue: section) {
        
        //section 0
        case .university:
            let count = resume.education.count
//            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .certifications:
            let count = resume.industryCertifications.count
//            print("Number of items for section \(section): \(count)\n")
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let resume = resume else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! EducationCell
        
        //set cell data object
        switch EducationSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .university:
            let courses = resume.education[indexPath.item]
            cell.setLabelsText(using: courses.course, for: 0)
            cell.setLabelsText(using: courses.location, for: 1)
            cell.setLabelsText(using: courses.graduationYear, for: 2)
            cell.setLabelsText(using: courses.school, for: 3)
            
            let image = UIImage(systemName: "checkmark.seal.fill")
            cell.setImage(with: image!)
//            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .certifications:
            let certifications = resume.industryCertifications[indexPath.item]
            cell.setLabelsText(using: certifications.certification, for: 0)
            cell.setLabelsText(using: certifications.location, for: 1)
            cell.setLabelsText(using: certifications.attainmentYear, for: 2)
            cell.setLabelsText(using: certifications.provider, for: 3)
            
            let image = UIImage(systemName: "doc.plaintext")
            cell.setImage(with: image!)
//            print("Cell for section \(indexPath.section) set")
            return cell

        case .none:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }
}
