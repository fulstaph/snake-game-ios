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
    
    override func loadView() {
        super.loadView()
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Экземпляр сцены
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let scene = GameScene(size: self.view.bounds.size)
            
            /// Главная обрасть экрана
            let skView = self.view as! SKView
            
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
