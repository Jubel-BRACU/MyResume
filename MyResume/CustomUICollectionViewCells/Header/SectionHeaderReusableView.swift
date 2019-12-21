//
//  CollectionViewCellSectionHeader.swift
//  MyResume
//
//  Created by Simon Italia on 12/16/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    
    //cell UI Outlets
    @IBOutlet weak var sectionHeadeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabelTextWith(string text: String) {
        sectionHeadeLabel.text = text
        
    }

}
