//
//  AcademicHelpViewController.swift
//  
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import TextFieldEffects
import FirebaseAuth

class AcademicHelpViewController: UIViewController {

    @IBOutlet weak var subjectTitle: AkiraTextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var greeting: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        print("here")
        if Manager.shared.justPosted == true && (Int(Date().timeIntervalSince1970) - Manager.shared.whenDidTheyPost)<1000 {
            Manager.shared.justPosted = false
            self.dismiss(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = "Hello, \(Auth.auth().currentUser!.email!.dropLast(8))"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        subjectTitle.inputAccessoryView = toolBar()
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        nextButton.layer.masksToBounds = true
        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Bold", size: 21) ?? UIFont(name: "Futura-Bold", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]
    }
    
    @IBAction func clickedGoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        performSegue(withIdentifier: "toSecond", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! SecondStepAcademicViewController
        destinationvc.subject = subjectTitle.text ?? ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
