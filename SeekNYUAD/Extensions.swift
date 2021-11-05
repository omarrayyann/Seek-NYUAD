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
