//
//  SettingsViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBAction func clickedLogout(_ sender: Any) {
        
     
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            self.logoutUser { success in
                DispatchQueue.main.async {
                    if success {
                      
                    
                        
                        self.navigationController?.popToRootViewController(animated: true)
                    
                    
                        
                        
                    }
                    else{
                        // error occured
                    }
                    
                    
                    
                    
                }
            }
            
            
            
           
            
        }
        
        
        
        ))
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)

        present(actionSheet, animated: true)

        
        

    
    }
    public func logoutUser(completion: (Bool) -> Void){
    
        do{
            try Auth.auth().signOut()
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }
    


}
