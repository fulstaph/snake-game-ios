//
//  GradientView.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

public final class GradientView: UIView {
    
    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as? CAGradientLayer ?? CAGradientLayer()
    }
    
    func update() {
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 213.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        let colorTop = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        gradientLayer.colors = [colorBottom, colorTop].compactMap{ $0.cgColor }
        gradientLayer.locations = [0.0, 1.0]
        
    }
    
    func update(_ colorBottom: UIColor, _ colorTop: UIColor) {
        gradientLayer.colors = [colorBottom, colorTop].compactMap{ $0.cgColor }
        gradientLayer.locations = [0.0, 1.0]
        
    }    
}
