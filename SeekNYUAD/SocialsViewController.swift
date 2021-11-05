//
//  SocialsViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class SocialsViewController: UIViewController {

    let db = Firestore.firestore()
    
    @IBOutlet weak var instagramUsername: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPrevious()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]
        // Do any additional setup after loading the view.
    }
    
    
    func loadPrevious(){
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).getDocument { snapshot, error in
            if let e = error {
                print(e)
            }
            else{
                if let instagramUsernameFromFirstore = snapshot?.data()!["insagram"] as? String {
                    self.instagramUsername.text = instagramUsernameFromFirstore
                }
                if let whatsappFromFirstore = snapshot?.data()!["whatsapp"] as? String {
                    self.phoneNumber.text = whatsappFromFirstore
                }
            }
        }
    }
    

    @IBAction func clickedSave(_ sender: Any) {
        var insta = "non"
        var whatsapp = "non"
        if let i = instagramUsername.text {
            if i != "" {
                insta = i
            }
        }
        if let w = phoneNumber.text {
            if w != "" {
                whatsapp = w
            }
        }
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).updateData(["instagram": insta, "whatsapp": whatsapp]) { error in
            if let e = error {
                print(e)
            }
            else{
                self.dismiss(animated: true)
                // succesfully saved
            }
        }
        
        
        
    }
    

}
