//
//  CollectionViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

private let sectionHeaderReuseIdentifier = "SectionHeaderResuableView"
private let professionalExperienceReuseIdentifier = "ProfessionlExperienceCell" 
private let developerExperienceReuseIdentifier = "DeveloperExperienceCell"

class ExperienceCollectionViewController: UICollectionViewController {
    
    //IB / UI Outlets
    @IBOutlet weak var experienceCollectionView: UICollectionView!
    
    //MARK: - Built in View handlers / methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes and nib files
        //Section Header Resuable View Class
        experienceCollectionView.register(UINib(nibName: "SectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier)

        //Cell Class
        //Section 0 cells (Professional Experience)
        experienceCollectionView.register(UINib(nibName: "ProfessionalExperienceCell", bundle: nil), forCellWithReuseIdentifier: professionalExperienceReuseIdentifier)
        
        //Section 1 cells (Professional Experience)
        experienceCollectionView.register(UINib(nibName: "DeveloperExperienceCell", bundle: nil), forCellWithReuseIdentifier: developerExperienceReuseIdentifier)
        
        //Setup compositional layout
        experienceCollectionView.collectionViewLayout = self.experienceCollectionView.setUpUICollectionViewCompositionLayout()
        
        //set layout
//        let layout = UICollectionViewFlowLayout()
//        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width, height: 30)

    }
    
    // MARK: - UICollectionView Delegates

    //set number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Section set")
        return 2
    }
    
    //set section header data
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            //instantiate SectionHeaderCollectionReusableView
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseIdentifier, for: indexPath) as! SectionHeaderReusableView
            
            //set header text for eeach section
            switch ExperienceSection(rawValue: indexPath.section) {
                
            //section 0
            case .professionalExperience:
                sectionHeaderView.setLabelTextWith(string: "Professional Experience")
                print("Header set for section: \(indexPath.section)")
              
            //section 1
            case .developerExperience:
             sectionHeaderView.setLabelTextWith(string: "Developer Experience")
                print("Header set for section: \(indexPath.section)")
            
            default:
                fatalError("Error! Failed to create section header")
            }

            return sectionHeaderView
        
        } else {
            return UICollectionReusableView()
        }

    }

    //define number of items per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard ViewController.resume != nil else { return 0 }
        
        switch ExperienceSection(rawValue: section) {
        
        //section 0
        case .professionalExperience:
            let count = ViewController.resume!.professionalExperience.count
            print("Number of items for section \(section): \(count)\n")
            return count
         
        //section 1
        case .developerExperience:
            let count = ViewController.resume!.developerExperience.count
            print("Number of items for section \(section): \(count)\n")
            return count
            
        default:
            fatalError("Error! Failed to set number of items / rows in section")
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard ViewController.resume != nil else {fatalError()}
        
        //set cell data object
        switch ExperienceSection(rawValue: indexPath.section) {
        
        //professional Experience Cell
        case .professionalExperience:
            let experience = ViewController.resume!.professionalExperience[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: professionalExperienceReuseIdentifier, for: indexPath) as! ProfessionalExperienceCell
                cell.setExperienceLabelsText(using: experience)
                cell.setDescrptionText(using: experience)
            
            print("Cell for section \(indexPath.section) set")
            return cell
            
        //developer experience cell
        case .developerExperience:
            let experience = ViewController.resume!.developerExperience[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: developerExperienceReuseIdentifier, for: indexPath) as! DeveloperExperienceCell
                cell.setExperienceLabelsText(using: experience)
                cell.setDescrptionText(using: experience)
            
            print("Cell for section \(indexPath.section) set")
            return cell

        default:
            fatalError("Error! Failed to set cell objects")
            
        } //end of switch
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
    
    

        

    
    
}


