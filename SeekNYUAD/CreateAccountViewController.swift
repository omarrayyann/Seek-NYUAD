//
//  CreateAccountViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var netidTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCreate.layer.cornerRadius = buttonCreate.frame.height / 10
        netidTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        netidTextField.delegate = self
    }
    
    @objc func textFieldDidChange() {
        if let netid = netidTextField.text {
            emailTextField.text = netid + "@nyu.edu"
        }
        
    }
 
  
    
    @IBAction func clickedCreate(_ sender: Any) {
        view.isUserInteractionEnabled = false
        buttonCreate.isUserInteractionEnabled = false
        if let netid = netidTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, let name = fullNameTextField.text {
            if (netid == "" && email == "" && password == "" && confirmPassword == "" && name != "") {
                errorLabel.text = "Fill all fields"
                errorLabel.isHidden = false
                errorLabel.shake()
                self.view.isUserInteractionEnabled = true
                self.buttonCreate.isUserInteractionEnabled = true
            }
            else if password == confirmPassword {
                if password.count < 6 {
                    errorLabel.text = "Password should be more than 6 characters"
                    errorLabel.isHidden = false
                    errorLabel.shake()
                    self.view.isUserInteractionEnabled = true
                    self.buttonCreate.isUserInteractionEnabled = true
                }
                else{
                Auth.auth().createUser(withEmail: email, password: password) { success, error in
                    if let e = error {
                        print(e)
                        self.view.isUserInteractionEnabled = true
                        self.buttonCreate.isUserInteractionEnabled = true
                    }
                    else{
                        self.insertNewUser(email: email, netid: netid, UID: success!.user.uid, name: name) { success in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            }
                            else{
                                print("error")
                                self.view.isUserInteractionEnabled = true
                                self.buttonCreate.isUserInteractionEnabled = true
                            }
                        }
                    }
                }}
            }
            else{
                errorLabel.text = "Passwords do not match"
                errorLabel.isHidden = false
                errorLabel.shake()
                self.view.isUserInteractionEnabled = true
                self.buttonCreate.isUserInteractionEnabled = true
            }
        }
    }
    

    let db = Firestore.firestore()
    
    public func insertNewUser (email: String, netid: String, UID: String, name: String, completion: @escaping (Bool) -> Void) {
        db.collection("Users").document(UID).setData(["netid": netid, "email": email, "uid": UID, "whatsapp": "non", "instagram": "non", "phonenumber": "non", "description": "non", "fullName": name]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(false)

                } else {
                    print("Document successfully written!")
                    
                    
                        self.db.collection("usersPosts").document(Auth.auth().currentUser!.uid).setData(["exists" : true, "posts": []]) { (error) in
                            if let e = error {
                                print(e)
                            }
                            else{
                                completion(true)
                            }
                        }

                    
                    

                }
            }

            
    
    }
    
}
