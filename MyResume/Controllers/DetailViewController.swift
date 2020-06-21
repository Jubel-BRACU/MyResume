//
//  DetailsViewController.swift
//  MyResume
//
//  Created by Simon Italia on 12/23/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Storyboard connections
    @IBOutlet weak var logoActivityIndicator: UIActivityIndicatorView!
    
    //IB Outlets
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet var labels: [UILabel]!
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        dismissView()
    }
    
    //MARK: - Class Properties
    
    //properties to receive data from passing VC
    var viewTitle: String?
    var viewDescription: String?
    var viewDetails: String?
    var viewImage: String?
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        performFetchLogo(name: viewImage)
    }
    
    
    private func updateUI() {
        
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
    

    private func performFetchLogo(name: String?) {
        guard let name = name else {
            self.setDefaultImage()
            return
        }
        
        showActivityIndicator(true)
        
        ResumeController.shared.getRemoteLogo(for: name) { [unowned self] (image, error) in
            
            self.showActivityIndicator(false)
            
            if let image = image {
                DispatchQueue.main.async {
                    self.imageView?.image = image
                    return
                }
                
            } else {
                self.setDefaultImage()
            }
            
            if let _ = error {
                self.setDefaultImage()
            }
        }
    }
    
    
    private func setDefaultImage() {
        DispatchQueue.main.async {
            self.imageView?.image = UIImage(systemName: "hammer.fill")
        }
    }
    
    
    private func showActivityIndicator(_ flag: Bool) {
        DispatchQueue.main.async {
            self.logoActivityIndicator.isHidden = !flag
            flag ? self.logoActivityIndicator.startAnimating() : self.logoActivityIndicator.stopAnimating()
        }
    }
    
    
    private func dismissView() {
       dismiss(animated: true, completion: nil)
   }
}
