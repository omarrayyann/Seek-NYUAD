//
//  ContactViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 06/11/2021.
//

import UIKit
import FirebaseFirestore
import MaterialActivityIndicator
import Kingfisher

class ContactViewController: UIViewController {

    @IBOutlet weak var instagramButon: UIButton!
    
    @IBOutlet weak var wholesStack: UIStackView!
    
    @IBOutlet weak var whatsappButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    

    
    let db = Firestore.firestore()
    
    var uid = ""
    
    var hasInstagram = false
    var hasWhatsapp = false
    var instagram = ""
    var whatsapp = ""
    
    
    func checkSocials(){
        activeIndicator.startAnimating()
        db.collection("Users").document(uid).getDocument { [self] snapshot, error in
            if let e = error {
                print(e)
            }
            else{
                if let instagramUsernameFromFirstore = snapshot?.data()!["instagram"] as? String {
                    if instagramUsernameFromFirstore != "non"{
                        self.instagram = instagramUsernameFromFirstore
                        self.hasInstagram = true
                    }
                }
                if let whatsappFromFirstore = snapshot?.data()!["whatsapp"] as? String {
                    if whatsappFromFirstore != "non"{
                        self.whatsapp = whatsappFromFirstore
                        self.hasWhatsapp = true
                        
                    }}
                print(hasWhatsapp)
                print(hasInstagram)
                activeIndicator.isHidden = true
                activeIndicator.stopAnimating()
                
                if hasWhatsapp == false && hasInstagram == false {
                    wholesStack.isHidden = true
                }
                else if hasWhatsapp == false {
                    whatsappButton.isHidden = true
                    wholesStack.isHidden = false
                }
                else if hasInstagram == false {
                    instagramButon.isHidden = true
                    wholesStack.isHidden = false
                }
                else{
                    wholesStack.isHidden = false
                }
                
                
            }
        }
        
       
        
        
        
    }
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSocials()
        whatsappButton.layer.cornerRadius = whatsappButton.frame.height/10
        instagramButon.layer.cornerRadius = instagramButon.frame.height/10
        whatsappButton.layer.borderWidth = 1
        instagramButon.layer.borderWidth = 1
        doneButton.layer.cornerRadius = doneButton.frame.height/2
        
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedInstagram(_ sender: Any) {
        let appURL = URL(string:  "instagram://user?username=\(instagram)")
            let webURL = URL(string:  "https://instagram.com/\(instagram)")

        if UIApplication.shared.canOpenURL(appURL!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL!)
                }
            } else {
                errorLabel.text = "You need to have instagram installed"
                errorLabel.isHidden = false
                errorLabel.shake()
            }
    }
    
    @IBAction func clickedWhatsapp(_ sender: Any) {
        // clicked whatsapp
        let urlWhats = "whatsapp://send?phone=\(whatsapp)"
           if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
               if let whatsappURL = URL(string: urlString) {
                   if UIApplication.shared.canOpenURL(whatsappURL){
                       if #available(iOS 10.0, *) {
                           UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                       } else {
                           UIApplication.shared.openURL(whatsappURL)
                       }
                   }
                   else {
                    errorLabel.text = "You need to have whatsapp installed"
                    errorLabel.isHidden = false
                    errorLabel.shake()
                    
                   }
               }
           }
    }
    
    
    @IBAction func clickedDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
