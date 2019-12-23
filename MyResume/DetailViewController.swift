//
//  DetailsViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/23/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //IB Outlets
    @IBOutlet var labels: [UILabel]!
    
    //properties to receive data from passing VC
    var viewTitle: String?
    var viewDescription: String?
    var viewDetails: String?
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        dismissView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup UI
        updateUI()
    }
    
    func updateUI() {
        
        //setup labels
        for label in labels {
            
            switch label.tag {
            case 0:
                label.text = viewTitle
                
            case 1:
            label.text = viewDescription
            
            case 2:
            label.text = viewDetails
                
            default:
                break
            }
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

