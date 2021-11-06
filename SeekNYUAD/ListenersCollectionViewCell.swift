//
//  ListenersCollectionViewCell.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 06/11/2021.
//

import UIKit

class ListenersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var netid: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var classOF: UILabel!

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var connectButton: UIButton!
    var listenerInfo = Listener(fullName: "", uid: "", netid: "", classOf: "", instagram: "", whatsapp: "")

    var delegate: MyCustomCellDelegatorTwo!

    var postinfo = Post(postuid: "", useruid: "", date: 0.0, subject: "", details: "", netid: "")

    override func awakeFromNib() {
        super.awakeFromNib()
        wholeView.layer.borderColor = #colorLiteral(red: 0.4090681076, green: 0.1202988401, blue: 0.594352901, alpha: 1)
        wholeView.layer.borderWidth = 1
        wholeView.layer.cornerRadius = wholeView.frame.height / 18
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.layer.borderWidth = 1
        connectButton.layer.cornerRadius = connectButton.frame.height / 12

    }
    
    @IBAction func clickedConnect(_ sender: Any) {
        self.delegate.callSegueFromCell(listenerInfo: listenerInfo)
    }

    
    
    
}
