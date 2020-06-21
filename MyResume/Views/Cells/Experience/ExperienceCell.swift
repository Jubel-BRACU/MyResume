//
//  ExperienceCollectionViewCell.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class ExperienceCell: UICollectionViewCell {
    
    //cell UI Outlets
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //set labels text
    func setLabelsText(using text: String, for tag: Int) {
        labels.sort(by: { $0.tag < $1.tag } )
        
        for label in labels {
            if label.tag == tag {
                label.text = text
            }
        }
    }
    
    
    //set image
    func setImage(with image: UIImage) {
        imageView.image = image
    }
}
