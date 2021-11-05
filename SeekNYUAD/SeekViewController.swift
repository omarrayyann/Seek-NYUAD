//
//  SeekViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit

class SeekViewController: UIViewController {

    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var mentalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        academicView.layer.cornerRadius = academicView.frame.height / 10
        academicView.layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.1215686275, blue: 0.5960784314, alpha: 1)
        academicView.layer.borderWidth = 2
        mentalView.layer.cornerRadius = mentalView.frame.height / 10
        mentalView.layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.1215686275, blue: 0.5960784314, alpha: 1)
        mentalView.layer.borderWidth = 2


    }
    

}
