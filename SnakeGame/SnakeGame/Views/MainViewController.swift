//
//  MainViewController.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 09/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var startGameButton: UIButton!
    
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
        self.title = "Main Screen"
        
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        
        startGameButton = UIButton(frame: .zero)
        startGameButton.addTarget(self, action: #selector(onStartGameButtonTapped), for: .touchUpInside)
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.setTitle("Start playing!", for: .normal)
        startGameButton.setTitleColor(.black, for: .normal)
        startGameButton.backgroundColor = .green
        startGameButton.layer.shadowColor = UIColor.gray.cgColor
        startGameButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        startGameButton.layer.shadowOpacity = 1.0
        startGameButton.layer.cornerRadius = 15
        view.addSubview(startGameButton)
        
        
        NSLayoutConstraint.activate([
            startGameButton.widthAnchor.constraint(equalToConstant: 150),
            startGameButton.heightAnchor.constraint(equalToConstant: 30),
            //button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 16/9),
            startGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startGameButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        ])
        
        print("main")
        // Do any additional setup after loading the view.
    }
    
    @objc func onStartGameButtonTapped() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
}
