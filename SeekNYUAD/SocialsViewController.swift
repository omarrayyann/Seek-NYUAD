//
//  SocialsViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import MaterialActivityIndicator


class SocialsViewController: UIViewController {

    @IBOutlet weak var classof2021: UIButton!
    @IBOutlet weak var classof2022: UIButton!
    @IBOutlet weak var classof2023: UIButton!
    @IBOutlet weak var classof2024: UIButton!
    @IBOutlet weak var classof2025: UIButton!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var instagramUsername: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPrevious()
        saveButton.layer.cornerRadius = saveButton.frame.height/2
        saveButton.layer.masksToBounds = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clicked2021(_ sender: Any) {
        disableAll()
        classof2021.layer.borderWidth = 1
        classOf = "2021"
    }
    
    @IBAction func clicked2022(_ sender: Any) {
        disableAll()
        classof2022.layer.borderWidth = 1
        classOf = "2022"
    }
    @IBAction func clicked2023(_ sender: Any) {
        disableAll()
        classof2023.layer.borderWidth = 1
        classOf = "2023"
        
    }
    @IBAction func clicked2024(_ sender: Any) {
        disableAll()
        classof2024.layer.borderWidth = 1
        classOf = "2024"
        
    }
    @IBAction func clicked2025(_ sender: Any) {
        disableAll()
        classof2025.layer.borderWidth = 1
        classOf = "2025"
    }
    
    var classOf = "non"
    func disableAll(){
        classof2021.layer.borderWidth = 0
        classof2022.layer.borderWidth = 0
        classof2023.layer.borderWidth = 0
        classof2024.layer.borderWidth = 0
        classof2025.layer.borderWidth = 0
    }
    @IBOutlet weak var activityIndicator: MaterialActivityIndicatorView!
    func loadPrevious(){
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).getDocument { [self] snapshot, error in
            if let e = error {
                print(e)
            }
            else{
                if let instagramUsernameFromFirstore = snapshot?.data()!["instagram"] as? String {
                    if instagramUsernameFromFirstore != "non"{
                        self.instagramUsername.text = instagramUsernameFromFirstore}
                }
                if let whatsappFromFirstore = snapshot?.data()!["whatsapp"] as? String {
                    if whatsappFromFirstore != "non"{
                    self.phoneNumber.text = whatsappFromFirstore
                    }}
                
                if let classs = snapshot?.data()!["classof"] as? String {
                    if classs != "non"{
                        if classs == "2021" {
                            clicked2021(classof2021)
                        }
                        if classs == "2022" {
                            clicked2022(classof2022)
                        }
                        if classs == "2023" {
                            clicked2023(classof2023)
                        }
                        if classs == "2024" {
                            clicked2024(classof2024)
                        }
                        if classs == "2025" {
                            clicked2025(classof2025)
                        }
                    }}
                
            }
        }
    }
    

    @IBAction func clickedSave(_ sender: Any) {
        activityIndicator.startAnimating()
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
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).updateData(["instagram": insta, "whatsapp": whatsapp, "classof": classOf]) { error in
            if let e = error {
                print(e)
            }
            else{
                self.navigationController?.popToRootViewController(animated: true)
                // succesfully saved
            }
        }
        
        
        
    }
    

}
