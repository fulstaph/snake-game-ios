//
//  GameViewController.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private let image = UIImageView(image: UIImage(named: "snakeCircle4"))
    
    private var gradient: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        grad.locations = [0.0, 1.0]
        grad.startPoint = CGPoint(x: 0.5, y: 1.0)
        grad.endPoint = CGPoint(x: 0.5, y: 0.0)
        return grad
    }()
    
    override func loadView() {
        super.loadView()
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let scene = GameScene(size: self.view.bounds.size)
        
        /// Главная обрасть экрана
        let skView = self.view as! SKView
        skView.backgroundColor = .clear
        gradient.frame = skView.bounds
        skView.layer.insertSublayer(gradient, at: 0)
        DispatchQueue.main.async {
            self.image.backgroundColor = .clear
            self.image.contentMode = .scaleAspectFill
            self.image.frame.size = CGSize(width: 100, height: 100)
            //image.center = view.center
        
            self.image.center = skView.center
            self.view.addSubview(self.image)
            /*
            UIView.animate(withDuration: 1.8) {
                self.image.transform = CGAffineTransform.init(rotationAngle: 1 * .pi)
                UIView.animate(withDuration: 0.8, animations: {
                    self.image.alpha = 0.0
                })
            }
            */
            UIView.animate(withDuration: 2.0,
                           delay: 0.0,
                           options: [.curveEaseInOut, .repeat, .autoreverse],
                           animations: { () -> Void in
                            self.image.transform = CGAffineTransform.init(rotationAngle: 1 * .pi)
                            UIView.animate(withDuration: 0.8, animations: {
                                self.image.alpha = 0.0
                            })
            }, completion: { (finished: Bool) -> Void in

            })
        }


        /// Экземпляр сцены
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            // Оторажение FPS
            skView.showsFPS = true
            
            // Количество объектов на экране
            skView.showsNodeCount = true
            
            skView.ignoresSiblingOrder = true
            
            // Растянуть на весь экран
            scene.scaleMode = .resizeFill
            
            // Выводим на экран
            skView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

    }
}
