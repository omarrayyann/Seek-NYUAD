//
//  SecondStepAcademicViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit

class SecondStepAcademicViewController: UIViewController {
    string subject = ""
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
                textView.layer.cornerRadius = textView.frame.height / 20
                textView.layer.borderWidth = 1
                textView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                subjectTitle.layer.cornerRadius = subjectTitle.frame.height / 14
                subjectTitle.layer.borderWidth = 1
                subjectTitle.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
