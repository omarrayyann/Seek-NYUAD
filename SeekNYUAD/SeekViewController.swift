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
        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]


        academicView.layer.cornerRadius = academicView.frame.height / 15
        academicView.layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.1215686275, blue: 0.5960784314, alpha: 1)
//        academicView.layer.borderWidth = 2
        mentalView.layer.cornerRadius = mentalView.frame.height / 15
        mentalView.layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.1215686275, blue: 0.5960784314, alpha: 1)
//        mentalView.layer.borderWidth = 2


    }
    

}
