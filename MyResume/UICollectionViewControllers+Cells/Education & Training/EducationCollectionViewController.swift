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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell classes and nib files
        //Section Header Resuable View Class
        collectionView.register(UINib(nibName: sectionHeaderReusableViewNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)

        //Cell Class
        collectionView.register(UINib(nibName: reusableCellNibName, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)

        //Setup compositional layout
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //set section header data
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
                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .certifications:
                let headerText = "Industry Certifications"
             sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
            
            default:
                fatalError("Error! Failed to create section header")
            }
        }
        
        return sectionHeaderView
    }

    //define number of items per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard ViewController.resume != nil else { return 0 }
        
        switch EducationSection(rawValue: section) {
        
        //section 0
        case .university:
            let count = ViewController.resume!.education.count
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .certifications:
            let count = ViewController.resume!.industryCertifications.count
            print("Number of items for section \(section): \(count)\n")
            return count
            
        default:
            fatalError("Error! Failed to set number of items / rows in section")
        }
    }

    
    //configure cell with data object
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard ViewController.resume != nil else {fatalError()}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! EducationCell
        
        //set cell data object
        switch EducationSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .university:
            
            let courses = ViewController.resume!.education[indexPath.item]
            for course in courses {
                switch course.key {
                
                case "course":
                    cell.setLabelsText(using: courses[course.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: courses[course.key]!, for: 1)
                 
                 case "graduation year":
                    cell.setLabelsText(using: courses[course.key]!, for: 2)
                    
                 case "school":
                    cell.setLabelsText(using: courses[course.key]!, for: 3)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "checkmark.seal.fill")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .certifications:
            
            let courses = ViewController.resume!.industryCertifications[indexPath.item]
            for course in courses {
                switch course.key {
                
                case "certification":
                    cell.setLabelsText(using: courses[course.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: courses[course.key]!, for: 1)
                 
                 case "attainment year":
                    cell.setLabelsText(using: courses[course.key]!, for: 2)
                    
                case "provider":
                cell.setLabelsText(using: courses[course.key]!, for: 3)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "doc.plaintext")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell

        default:
            fatalError("Error! Failed to set cell objects")
        }
    }


}
