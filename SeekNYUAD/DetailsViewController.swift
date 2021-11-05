//
//  DetailsViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit
import SwiftUI
import BonsaiController


class DetailsViewController: UIViewController {

    @IBOutlet weak var byWho: UILabel!
    
    @IBOutlet weak var userpic: UIImageView!
    @IBOutlet var offerSupportButton: UIView!
    @IBOutlet weak var details: UILabel!
    var postInfo: Post = Post(postuid: "", useruid: "", date: 0.0, subject: "", details: "", netid: "")
    @IBOutlet weak var subjectsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        userpic.layer.cornerRadius = userpic.frame.height / 2
        userpic.layer.borderWidth = 1

        offerSupportButton.layer.cornerRadius = offerSupportButton.frame.height/2
        subjectsLabel.text = postInfo.subject
        details.text = postInfo.details
        byWho.text = postInfo.netid
    }
    


    @IBAction func clickedOfferSupport(_ sender: Any) {
        let smallVC = storyboard!.instantiateViewController(identifier: "contact") as! ContactViewController
        smallVC.transitioningDelegate = self
        smallVC.uid = postInfo.useruid
        smallVC.modalPresentationStyle = .custom
            present(smallVC, animated: true, completion: nil )
        
    }
    
    
    @IBOutlet weak var classOf: UILabel!
    
}




extension DetailsViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        /// With Background Color ///
    
        // Slide animation from .left, .right, .top, .bottom
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
    
    
        /// With Blur Style ///
        
        // Slide animation from .left, .right, .top, .bottom
        //return BonsaiController(fromDirection: .bottom, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, blurEffectStyle: .dark,  presentedViewController: presented, delegate: self)
    }
    
    
}
