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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var labels: [UILabel]!
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        dismissView()
    }
    
    //properties to receive data from passing VC
    var viewTitle: String?
    var viewDescription: String?
    var viewDetails: String?
    var viewImage: String?
    
    
    //MARK: - View Lifecycle
    
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
        
        //set image
        if let image = viewImage {
            let logo = getLogo(image: image, type: ".png")
            imageView.image = logo
        }
    }
    
    
    //fetch image file from bundle
    func getLogo(image named: String, type: String) -> UIImage {
        let image = UIImage(named: named+type)
        
        if let image = image {
            return image
        
        } else {
            print("Error! Image cannot be loaded, or was not found. Loading default image")
            return UIImage(systemName: "hammer.fill")!
        }
        
    }
    
    func dismissView() {
       dismiss(animated: true, completion: nil)
   }
}
