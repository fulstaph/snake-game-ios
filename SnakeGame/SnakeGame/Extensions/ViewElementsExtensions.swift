//
//  ViewElementsExtensions.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 11/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIButton {
    func scale() {
        UIView.animate(withDuration: 1.0,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 2.0, y: 1.5)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.transform = CGAffineTransform.identity
                        }
        })
    }
}
