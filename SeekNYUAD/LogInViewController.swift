//
//  LogInViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class LogInViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var netidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.height/12
        netidTextField.inputAccessoryView = toolBar()
        passwordTextField.inputAccessoryView = toolBar()

    }
    
    @IBAction func clickedSignIn(_ sender: Any) {
        errorLabel.isHidden = true
        if let netid = netidTextField.text, let password = passwordTextField.text {
            if (netid == "" || password == "") {
                errorLabel.text = "Fill all Fields"
                errorLabel.isHidden = false
                errorLabel.shake()
            }
            else{
                Auth.auth().signIn(withEmail: netid + "@nyu.edu", password: password) { success, error in
                    if let e = error {
                        print(e)
                        self.errorLabel.text = "Wrong Info"
                        self.errorLabel.isHidden = false
                        self.errorLabel.shake()
                    }
                    else{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        else{
            errorLabel.isHidden = false
            errorLabel.shake()
        }
    }
    

}
