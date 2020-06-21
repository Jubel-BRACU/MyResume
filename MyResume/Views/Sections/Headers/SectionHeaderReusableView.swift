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
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
   func setLabelTextWith(string text: String) {
        sectionHeaderLabel.text = text
    }
}
