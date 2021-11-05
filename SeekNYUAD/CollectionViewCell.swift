//
//  CollectionViewCell.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var netidLabel: UILabel!
    
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var backView: UIView!
    var subject = ""
    var details = ""
    var uid = ""
    var postinfo = Post(postuid: "", useruid: "", date: 0.0, subject: "", details: "", netid: "")
    var date = 0.0
    var delegate: MyCustomCellDelegator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = backView.frame.height / 18
        supportButton.layer.cornerRadius = supportButton.frame.height / 12
        
    }

    @IBAction func clickedSupport(_ sender: Any) {
        self.delegate.callSegueFromCell(postInfo: postinfo)
    }
}
