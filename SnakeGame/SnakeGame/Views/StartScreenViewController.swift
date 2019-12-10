//
//  StartViewController.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 09/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    private var button: UIButton!
    
    private let logo = UIImageView(image: UIImage(named: "logo"))
    
    private var gradient: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        grad.locations = [0.0, 1.0]
        grad.startPoint = CGPoint(x: 0.5, y: 1.0)
        grad.endPoint = CGPoint(x: 0.5, y: 0.0)
        return grad
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = "Hello!"
        logo.contentMode = .scaleAspectFill
        logo.frame.size = CGSize(width: 100, height: 100)
        logo.center = view.center
        logo.center.y -= 200
        view.addSubview(logo)
        //view.backgroundColor = .clear
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(onStartButtonTap), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 30),
            //button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 16/9),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        ])
        
        print("start screen")
        // Do any additional setup after loading the view.
    }
    
    @objc func onStartButtonTap() {
        if AppDelegate.shared.logged {
            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
            AppDelegate.shared.rootViewController.switchToAuthScreen()
        }
    }

}
