//
//  BecomeAListenerViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 06/11/2021.
//

import UIKit

class BecomeAListenerViewController: UIViewController {

    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var success: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = doneButton.frame.height/2
        applyButton.layer.cornerRadius = applyButton.frame.height/2

    }
    
    @IBAction func clickedDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
   
    @IBAction func clickedApply(_ sender: Any) {
        applyButton.isHidden = true
        success.isHidden = false
    }
}
