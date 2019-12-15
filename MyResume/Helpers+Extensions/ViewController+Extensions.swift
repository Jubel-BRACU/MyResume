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
        
        if let _ = error {
            //show error alert
            
           //dimiss the controller
           controller.dismiss(animated: true, completion: nil)
           return
       }
        
        switch result {
            case .cancelled:
                print("Action cancelled")
                
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
            mailComposerVC.setToRecipients(emails)
            mailComposerVC.setSubject("Job Opportunity")
            mailComposerVC.setMessageBody("Hi Simon, We reviewed your resume and...", isHTML: false)
            self.present(mailComposerVC, animated: true, completion: nil)
        }
    }
    
}
