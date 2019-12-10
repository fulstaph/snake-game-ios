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
    
    //private var currentPlayer: CurrentPlayer?
    
    private var gradient: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        grad.locations = [0.0, 1.0]
        grad.startPoint = CGPoint(x: 0.5, y: 1.0)
        grad.endPoint = CGPoint(x: 0.5, y: 0.0)
        return grad
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello, \(CurrentPlayerSingleton.shared.player.name)!"
        
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        print("main")
        // Do any additional setup after loading the view.
    }
    
    @objc func logout() {
        let alert = UIAlertController(title: "Logging out", message: "Are you sure you'd like to log out?", preferredStyle: .alert)
        
        let logout = UIAlertAction(title: "Yes", style: .destructive) { (action:UIAlertAction) in
            AppDelegate.shared.rootViewController.switchToAuthScreen()
        }
        let stay = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in }
        stay.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(stay)

        alert.addAction(logout)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func onStartGameButtonTapped() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
}
