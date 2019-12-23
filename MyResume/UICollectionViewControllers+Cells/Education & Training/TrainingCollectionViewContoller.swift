//
//  TrainingCollectionViewController.swift
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

class TrainingCollectionViewController: UICollectionViewController {

    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch TrainingSection(rawValue: sectionIndex) {
            case .projectBased:
                return self?.setupLayoutOne()
                
            case .foundational:
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
            switch TrainingSection(rawValue: indexPath.section) {
                
            //section 0
            case .projectBased:
                let headerText = "Project Based Courses"
                sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .foundational:
                let headerText = "Foundational Courses"
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
        
        switch TrainingSection(rawValue: section) {
        
        //section 0
        case .projectBased:
            let count = ViewController.resume!.projectBasedCourses.count
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .foundational:
            let count = ViewController.resume!.foundationalCourses.count
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
        switch TrainingSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .projectBased:
            
            let courses = ViewController.resume!.projectBasedCourses[indexPath.item]
            for course in courses {
                switch course.key {
                
                case "course":
                    cell.setLabelsText(using: courses[course.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: courses[course.key]!, for: 1)
                 
                 case "completion year":
                    cell.setLabelsText(using: courses[course.key]!, for: 2)
                    
                 case "provider":
                    cell.setLabelsText(using: courses[course.key]!, for: 3)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "hammer.fill")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .foundational:
            
            let courses = ViewController.resume!.foundationalCourses[indexPath.item]
            for course in courses {
                switch course.key {
                
                case "course":
                    cell.setLabelsText(using: courses[course.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: courses[course.key]!, for: 1)
                 
                 case "completion year":
                    cell.setLabelsText(using: courses[course.key]!, for: 2)
                    
                case "provider":
                cell.setLabelsText(using: courses[course.key]!, for: 3)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "book.fill")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell

        default:
            fatalError("Error! Failed to set cell objects")
        }
    }


}
