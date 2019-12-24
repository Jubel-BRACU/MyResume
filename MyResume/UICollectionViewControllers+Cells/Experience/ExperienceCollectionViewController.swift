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
    
    //MARK: - Built in View handlers / methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //Register cell classes and nib files
        //Section Header Resuable View Class
        collectionView.register(UINib(nibName: sectionHeaderReusableViewNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)

        //Cell Class
        collectionView.register(UINib(nibName: reusableCellNibName, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        //Setup compositional layout
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    //set number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Section set")
        return 2
    }
    
    //set section header data
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //instantiate SectionHeaderCollectionReusableView
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //set header text for eeach section
            switch ExperienceSection(rawValue: indexPath.section) {
                
            //section 0
            case .professional:
                let headerText = "Professional Experience"
                sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .developer:
                let headerText = "Developer Experience"
             sectionHeaderView.setLabelTextWith(string: headerText)
                print("Header set for section: \(indexPath.section)")
            
            case .none:
                fatalError("Error! Unknown case, failed to create section header")
            }
        }

        return sectionHeaderView
    }

    //define number of items per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard ViewController.resume != nil else { return 0 }
        
        switch ExperienceSection(rawValue: section) {
        
        //section 0
        case .professional:
            let count = ViewController.resume!.professionalExperience.count
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .developer:
            let count = ViewController.resume!.developerExperience.count
            print("Number of items for section \(section): \(count)\n")
            return count
            
        case .none:
            fatalError("Error! Unknown case, failed to set number of items / rows in section")
        }
    }

    //configure cell with data object
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard ViewController.resume != nil else { fatalError() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! ExperienceCell
        
        //set cell data object
        switch ExperienceSection(rawValue: indexPath.section) {
            
        //section 0 cell
        case .professional:
            
            let experiences = ViewController.resume!.professionalExperience[indexPath.item]
            for experience in experiences {
                switch experience.key {
                
                case "company":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 1)
                 
                 case "period":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 2)
                    
                 case "job title":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 3)
                    
                case "description":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 4)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "briefcase.fill")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell
            
        //section 1 cell
        case .developer:
            
            let experiences = ViewController.resume!.developerExperience[indexPath.item]
            for experience in experiences {
                switch experience.key {
                
                case "language":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 0)

                 case "location":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 1)
                 
                 case "period":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 2)
                    
                 case "projects":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 3)
                    
                case "description":
                    cell.setLabelsText(using: experiences[experience.key]!, for: 4)
                    
                 default:
                    break
                }
            }
            
            let image = UIImage(systemName: "globe")
            cell.setImage(with: image!)
            print("Cell for section \(indexPath.section) set")
            return cell

        case .none:
            fatalError("Error! Unknown case, failed to set cell objects")
        }
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard ViewController.resume != nil else { fatalError() }
        
        //instantiate desitination vc
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //pass cell object data, based on cell of section
        switch ExperienceSection(rawValue: indexPath.section) {
        case .professional:
            
            //get object item
            let item = ViewController.resume!.professionalExperience[indexPath.item]
            vc.viewTitle = item["job title"]
            vc.viewDescription = item["description"]
            vc.viewDetails = item["accomplishments"]
            vc.viewImage = item["image"]

        case .developer:
            let item = ViewController.resume!.developerExperience[indexPath.item]
            vc.viewTitle = item["language"]
            vc.viewDescription = item["description"]
            vc.viewDetails = item["technologies"]
            vc.viewImage = item["image"]
               
        case .none:
            fatalError("Error! Unknown case, failed to set destination VC properties")
       }
         
        //display DetailVC
        self.present(vc, animated: true, completion: nil)
    }
    
}
    
    




