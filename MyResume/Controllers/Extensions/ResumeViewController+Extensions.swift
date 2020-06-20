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


extension ResumeViewController: MFMailComposeViewControllerDelegate {
    
    //Load Safari
    func loadWebsite(url string: String) {
        DispatchQueue.main.async { [unowned self] in
            let url = URL(string: string)!
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    
    //Mail Controller delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
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
            
        @unknown default:
            fatalError("Fatal error: \(String(describing: error?.localizedDescription))")
        }

        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //load Mail Composer
    func loadMailComposer(to emails: [String]) {
        
        guard MFMailComposeViewController.canSendMail() else {
            DispatchQueue.main.async { [unowned self] in
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
    func setContactInfoLabels(resume: ResumeObject, labels: [UILabel]) {
        
        for label in labels {
            
            switch label.tag {
            case ContactLabel.name.rawValue:
                label.text = resume.contactInformation.name.uppercased()
                
            case ContactLabel.phone.rawValue:
                label.text = resume.contactInformation.phone
                
            case ContactLabel.email.rawValue:
                label.text = resume.contactInformation.email
                
            default:
                break
            }
        }
    }
    
    
    //Set Webiste Links
    func setWebsiteLabels(resume: ResumeObject, labels: [UILabel]) {
        
        let urlType = "https://"
        for label in labels {

            switch label.tag {
            case WebsiteLabel.linkedin.rawValue:
                let string = resume.websites[label.tag].url
                let text = string?.createAtrributedString(type: urlType)
                label.attributedText = text
                    
            case WebsiteLabel.github.rawValue:
                 let string = resume.websites[label.tag].url
                 let text = string?.createAtrributedString(type: urlType)
                 label.attributedText = text
                
            case WebsiteLabel.website.rawValue:
                let string = resume.websites[label.tag].url
                let text = string?.createAtrributedString(type: urlType)
                label.attributedText = text
                
            default:
                break
            }
        }
    }
    
    
    //Set Profile info
    func setProfileInfo(resume: ResumeObject, label: UILabel, textViews: [UITextView]?) {
        
        label.text = resume.profile.profession
        
        //set text views
        if let textViews = textViews {
            for textView in textViews {
            
                switch textView.tag {
                case ProfileTextViews.general.rawValue:
                    textView.text = resume.profile.general
                    
                case ProfileTextViews.valueProposition.rawValue:
                    textView.text = resume.profile.valueProposition
                    
                default:
                    break
                }
            }
        }
    }
}
