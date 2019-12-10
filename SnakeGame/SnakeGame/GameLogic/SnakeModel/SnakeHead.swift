//
//  SnakeHead.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//
import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint){
        super.init(atPoint: point)
        
        // Категория - голова
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        
        // Пересекается с телом, яблоком и границей экрана
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
