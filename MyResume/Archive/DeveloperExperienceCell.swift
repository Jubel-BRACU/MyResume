//
//  DeveloperExperienceCollectionViewCell.swift
//  MyResume
//
//  Created by Simon Italia on 12/20/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class DeveloperExperienceCell: UICollectionViewCell {
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //set labels text
    func setExperienceLabelsText(using text: String, for tag: Int) {
        labels.sort(by: { $0.tag < $1.tag } )
        
        for label in labels {
            if label.tag == tag {
                label.text = text
            }
        }
    }
        
    //set text view text
    func setDescrptionText(using text: String) {
        textView.text = text
    }
    
//    //set labels text
//    func setExperienceLabelsText(using dictionary: [String: String]) {
//
//        for label in labels {
//
//            switch label.tag {
//
//            case DeveloperExperience.language.rawValue:
//                label.text = dictionary["language"]
//
//            case DeveloperExperience.location.rawValue:
//               label.text = dictionary["location"]
//
//            case DeveloperExperience.period.rawValue:
//                label.text = dictionary["period"]
//
//            case DeveloperExperience.projects.rawValue:
//                label.text = dictionary["projects"]
//
//            default:
//                fatalError()
//            }
//        }
//    }
//
//    //set text view text
//    func setDescrptionText(using dictionary: [String: String]) {
//        textView.text = dictionary["description"]
//    }

}
