//
//  AcademicHelpViewController.swift
//  
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import TextFieldEffects

class AcademicHelpViewController: UIViewController {

    @IBOutlet weak var subjectTitle: AkiraTextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        destinationvc.subject = subjectTitle.text
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
