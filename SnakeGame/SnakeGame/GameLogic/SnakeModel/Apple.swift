//
//  Apple.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import SpriteKit

/// Яблоко
class Apple: SKShapeNode {
    
    // Инициализация яблока
    convenience init(position: CGPoint) {
        self.init()
        
        // Рисуем круг
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 15, height: 15)).cgPath
        
        // Заливаем цветом
        fillColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        // Ширина рамки 5 поинтов
        lineWidth = 0
        
        self.position = position
        
        // Добавялем физическое тело совпадающее с изображением яблока
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x:5, y:5))
        
        // Категория - яблоко
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
