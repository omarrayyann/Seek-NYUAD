//
//  SecondStepAcademicViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import MaterialActivityIndicator
import FirebaseFirestore
import FirebaseAuth


class SecondStepAcademicViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: MaterialActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    var subject = ""
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.layer.cornerRadius = loadingView.frame.height/20
        nextButton.layer.cornerRadius = nextButton.frame.height/2
        nextButton.layer.masksToBounds = true
        labelAcademic.text = subject
                textView.layer.cornerRadius = textView.frame.height / 25
                textView.layer.borderWidth = 1
                textView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.549807363)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Futura Bold", size: 21) ?? UIFont(name: "Futura-Bold", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .medium)]
        self.navigationController?.title = subject
    }
    
    @IBOutlet weak var labelAcademic: UILabel!
    @IBAction func clickedBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let db = Firestore.firestore()
    
    @IBAction func clickedSeek(_ sender: Any) {
        
        if let additionalText = textView.text {
            if (additionalText != "") {
                postNow()
                activityIndicator.startAnimating()
                wholeView.isHidden = false
            }}
    }
 
    
    func postNow(){
        
        
        var dateNow = Date().timeIntervalSince1970
        
     
                let randomUID =  "\(NSUUID().uuidString)"
         
                db.collection("usersPosts").document(Auth.auth().currentUser!.uid).updateData([randomUID: [
                    "netid": Auth.auth().currentUser?.email?.dropLast(8),
                    "postUID": randomUID,
                    "subject": subject,
                    "details": textView.text ?? "",
                    "userUID": Auth.auth().currentUser!.uid,
                    "date": dateNow], "posts": FieldValue.arrayUnion([randomUID])]) { [self] (error) in
                    if let e = error {
                        print(e)
                        wholeView.isHidden = true

                    }
                    else{
                        // success in sending it to post
                        db.collection("allPosts").document("academicSeeks").updateData([randomUID: [
                            "netid": Auth.auth().currentUser?.email?.dropLast(8),
                            "postUID": randomUID,
                            "subject": subject,
                            "details": textView.text ?? "",
                            "userUID": Auth.auth().currentUser!.uid,
                            "date": dateNow], "posts": FieldValue.arrayUnion([randomUID])]) { (error) in
                            if let e = error {
                                print(e)
                                wholeView.isHidden = true

                            }
                            else{
                                Manager.shared.justPosted = true
                                Manager.shared.whenDidTheyPost = Int(Date().timeIntervalSince1970)
                                self.dismiss(animated: true) {
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                                    }
                                }
                    }
                }
    }
                
    
                
            
            
            
            
    
}
