//
//  Extensions.swift
//  SeekNYUAD
//
//  Created by Omar Rayyan on 05/11/2021.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -5.0, 5.0, -2.5, 2.5, -1.25, 1.25, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}


extension UIViewController{
    func toolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.init(red: 18/255, green: 93/255, blue: 152/255, alpha: 1) //Write what you want for color
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var buttonTitle = "Done" //Or "Tamam"
        var cancelButtonTitle = "Cancel" //Or "İptal" for Turkish
        let doneButton = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(onClickDoneButton))
        let cancelButton = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(onClickCancelButton))
        doneButton.tintColor = .white
        cancelButton.tintColor = .white
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }

    @objc func onClickDoneButton(){
        view.endEditing(true)
    }

    @objc func onClickCancelButton(){
        view.endEditing(true)
    }
}
