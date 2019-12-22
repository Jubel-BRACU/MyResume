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

    //set number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //set section header data
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //instantiate SectionHeaderCollectionReusableView
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
            
            default:
                fatalError("Error! Failed to create section header")
            }
        }
        
        return sectionHeaderView
    }

    //define number of items per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard ViewController.resume != nil else { return 0 }
        
        switch ProjectSection(rawValue: section) {
        
        //section 0
        case .personal:
            let count = ViewController.resume!.personalProjects.count
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .coursework:
            let count = ViewController.resume!.courseworkProjects.count
            print("Number of items for section \(section): \(count)\n")
            return count
            
        default:
            fatalError("Error! Failed to set number of items / rows in section")
        }
    }

    //configure cell with data object
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard ViewController.resume != nil else {fatalError()}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! iOSProjectCell
        
        //set cell data object
        switch ProjectSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .personal:
            
            let projects = ViewController.resume!.personalProjects[indexPath.item]
            for project in projects {
                switch project.key {
                
                case "project name":
                    cell.setLabelsText(using: projects[project.key]!, for: 0)

                 case "date":
                    cell.setLabelsText(using: projects[project.key]!, for: 1)
                 
                 case "description":
                    cell.setLabelsText(using: projects[project.key]!, for: 2)
                    
                 case "github":
                    cell.setLabelsText(using: projects[project.key]!, for: 3)
                    
                case "technologies":
                    cell.setLabelsText(using: projects[project.key]!, for: 4)
                    
                 default:
                    break
                }
            }
            
            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .coursework:
            
            let projects = ViewController.resume!.courseworkProjects[indexPath.item]
            for project in projects {
                switch project.key {
                
                case "project name":
                    cell.setLabelsText(using: projects[project.key]!, for: 0)

                 case "date":
                    cell.setLabelsText(using: projects[project.key]!, for: 1)
                 
                 case "description":
                    cell.setLabelsText(using: projects[project.key]!, for: 2)
                    
                 case "github":
                    cell.setLabelsText(using: projects[project.key]!, for: 3)
                    
                case "technologies":
                    cell.setLabelsText(using: projects[project.key]!, for: 4)
                    
                 default:
                    break
                }
            }
            
            print("Cell for section \(indexPath.section) set")
            return cell

        default:
            fatalError("Error! Failed to set cell objects")
        }
    }
    
}
