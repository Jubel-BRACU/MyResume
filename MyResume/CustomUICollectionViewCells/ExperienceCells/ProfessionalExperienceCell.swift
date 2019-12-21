//
//  ExperienceCollectionViewCell.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class ProfessionalExperienceCell: UICollectionViewCell {
    
    //cell UI Outlets
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var textView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //set labels text
    func setExperienceLabelsText(using dictionary: [String: String]) {
        
        for label in labels {
            
            switch label.tag {
                
            case ProfessionalExperience.company.rawValue:
                label.text = dictionary["company"]
                
            case ProfessionalExperience.location.rawValue:
               label.text = dictionary["location"]
                
            case ProfessionalExperience.period.rawValue:
                label.text = dictionary["period"]
                
            case ProfessionalExperience.jobTitle.rawValue:
                label.text = dictionary["job title"]
                 
            default:
                fatalError()
            }
        }
    }
    
    //set text view text
    func setDescrptionText(using dictionary: [String: String]) {
        textView.text = dictionary["description"]
    }
    

}
