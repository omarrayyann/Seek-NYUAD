//
//  SeekViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import FirebaseAuth

class SeekViewController: UIViewController {

    @IBOutlet weak var helpView: UIButton!
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var mentalView: UIView!
    
    @IBOutlet weak var becomeHelperButton: UIView!
    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser == nil){
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Medium", size: 21) ?? UIFont(name: "Futura-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]

        mentalView.layer.cornerRadius = mentalView.frame.height / 20
        academicView.layer.cornerRadius = academicView.frame.height / 20

        
   


    }
    

}
