//
//  DetailsViewController.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var byWho: UILabel!
    
    @IBOutlet weak var details: UILabel!
    var postInfo: Post = Post(postuid: "", useruid: "", date: 0.0, subject: "", details: "", netid: "")
    @IBOutlet weak var subjectsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsLabel.text = postInfo.subject
        details.text = postInfo.details
        byWho.text = "by \(postInfo.netid)"
    }
    

    

}
