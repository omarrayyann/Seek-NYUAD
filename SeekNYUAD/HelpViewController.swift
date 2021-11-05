//
//  HelpViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseAuth

class HelpViewController: UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser == nil){
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
  
    func logoutUser(completion: (Bool) -> Void){
    
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
            
        }
        
        
    }
}
