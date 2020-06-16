//
//  OpenInSafari.swift
//  SimonItaliaResume
//
//  Created by Simon Italia on 12/15/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import MessageUI

//helper to open web links inside safari in app
extension ViewController: MFMailComposeViewControllerDelegate {
    
    //MARK: - Load Safari
    func loadWebsite(url string: String) {
        DispatchQueue.main.async { [unowned self] in
            let url = URL(string: string)!
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Load Mail Composer
    //Mail Controller delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let error = error {
            //show error alert
            print(error.localizedDescription)
           
            //dimiss the controller
           controller.dismiss(animated: true, completion: nil)
           return
       }
        
        switch result {
            case .cancelled:
                print("Mail draft deleted")
                
            case .failed:
                print("Mail failed")
                
            case .saved:
                print("Mail draft saved")
                
            case .sent:
                print("Mail sent")
            
        //deal with unknown cases
        @unknown default:
            fatalError("Fatal error: \(String(describing: error?.localizedDescription))")
        }
        
        //dismiss mail controller
        controller.dismiss(animated: true, completion: nil)
    }
    
    //load Mail Composer
    func loadMailComposer(to emails: [String]) {
        
        guard MFMailComposeViewController.canSendMail() else {
            DispatchQueue.main.async { [unowned self] in
                //show error alert
                let ac = UIAlertController(title: "ERROR!", message: "Mail app not configured.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(ac, animated: true)
            }
            
            return
        }
        
        DispatchQueue.main.async { [unowned self] in
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
                //set vc to mail composer delegate
            
            mailComposerVC.setToRecipients(emails)
            mailComposerVC.setSubject("Job Opportunity")
            mailComposerVC.setMessageBody("Hi Simon, We reviewed your resume and...", isHTML: false)
            self.present(mailComposerVC, animated: true, completion: nil)
        }
    }
    
    //trigger call phone number
    func callNumber(number: String) {
        let url = URL(string: number)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    
    //Set Contact info labels
    func setContactInfoLabels(resume: Resume?, labels: [UILabel]) {
        guard resume != nil else { return }
        
        let dict = resume?.contactInformation.first
        for label in labels {
            
            switch label.tag {
            case ContactLabel.name.rawValue:
                label.text = dict?["name"]
                
            case ContactLabel.phone.rawValue:
                label.text = dict?["phone"]
                
            case ContactLabel.email.rawValue:
                label.text = dict?["email"]
                
            default:
                break
            }
        }
    }
    
    //Set Webiste Links
    func setWebsiteLabels(resume: Resume?, labels: [UILabel]) {
        guard resume != nil else { return }
        
        let urlType = "https://"
        let dict = resume?.websites.first
       
        for label in labels {

            switch label.tag {
            case WebsiteLabel.linkedin.rawValue:
                let string = dict?["linkedin"]
                let text = string?.createAtrributedString(type: urlType)
                label.attributedText = text
                    
            case WebsiteLabel.github.rawValue:
                let string = dict?["github"]
                let text = string?.createAtrributedString(type: urlType)
                label.attributedText = text
                
            case WebsiteLabel.website.rawValue:
                let string = dict?["businesss website"]
                let text = string?.createAtrributedString(type: urlType)
                label.attributedText = text
                
            default:
                break
            }
        }
    }
    
    //Ste Profile info
    func setProfileInfo(resume: Resume?, label: UILabel, textViews: [UITextView]?) {
        guard resume != nil else { return }
        
        let dict = resume?.profile.first
        
        //set labels
        let text = dict?["profession"]
        label.text = text
        
        //set text views
        if let textViews = textViews {
            for textView in textViews {
            
                switch textView.tag {
                case ProfileTextViews.general.rawValue:
                    textView.text = dict?["general"]
                    
                case ProfileTextViews.valueProposition.rawValue:
                    textView.text = dict?["value proposition"]
                    
                default:
                    break
                }
            }
        }
    }
}
