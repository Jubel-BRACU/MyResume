//
//  TrainingCollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/22/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

//private let sectionHeaderReuseIdentifier = "SectionHeaderReusableView"
//private let sectionHeaderReusableViewNibName = sectionHeaderReuseIdentifier
fileprivate let cellReuseIdentifier = "EducationCell"
fileprivate let reusableCellNibName = cellReuseIdentifier


class TrainingCollectionViewController: UIViewController {
    

    //MARK: - Storyboard Connections
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - Class Properties
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch TrainingSection(rawValue: sectionIndex) {
            case .projectBased:
                return self?.setupEducationAndTrainingLayout()

            case .foundational:
                return self?.setupEducationAndTrainingLayout()
                
            default:
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
        configureCollectionView()
    }
    
    
    //MARK: - Configuration
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        
        //custom cell and xib file registrations
        collectionView.register(UINib(nibName: sectionHeaderReusableViewNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)
        collectionView.register(UINib(nibName: reusableCellNibName, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)

        //Setup compositional layout
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
    }
}


// MARK: - UICollectionViewDataSource

extension TrainingCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //instantiate SectionHeaderCollectionReusableView
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //set header text for eeach section
            switch TrainingSection(rawValue: indexPath.section) {
                
            //section 0
            case .projectBased:
                let headerText = "Project Based Courses"
                sectionHeaderView.setLabelTextWith(string: headerText)
              
            //section 1
            case .foundational:
                let headerText = "Foundational Courses"
             sectionHeaderView.setLabelTextWith(string: headerText)
            
            case .none:
                fatalError("Error! Unknown case, failed to create section header")
            }
        }
        
        return sectionHeaderView
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resume = resume else { return 0 }
        
        switch TrainingSection(rawValue: section) {
        
        //section 0
        case .projectBased:
            let count = resume.swiftProjectBasedCourses.count
            return count
         
        //section 1
        case .foundational:
            let count = resume.swiftFoundationalCourses.count
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let resume = resume else { fatalError("Resume object should not be nil") }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! EducationCell
        
        //set cell data object
        switch TrainingSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .projectBased:
            let courses = resume.swiftProjectBasedCourses[indexPath.item]
            cell.setLabelsText(using: courses.course, for: 0)
            cell.setLabelsText(using: courses.location, for: 1)
            cell.setLabelsText(using: courses.completionYear, for: 2)
            cell.setLabelsText(using: courses.provider, for: 3)
            
            let image = UIImage(systemName: "hammer.fill")
            cell.setImage(with: image!)
            return cell
            
        //section 1 cell
        case .foundational:
            let courses = resume.swiftFoundationalCourses[indexPath.item]
            cell.setLabelsText(using: courses.course, for: 0)
            cell.setLabelsText(using: courses.location, for: 1)
            cell.setLabelsText(using: courses.completionYear, for: 2)
            cell.setLabelsText(using: courses.provider, for: 3)
            
            let image = UIImage(systemName: "book.fill")
            cell.setImage(with: image!)
            return cell

        case .none:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }
}
