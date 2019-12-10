//
//  GameScene.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import SpriteKit
import GameplayKit

/// Пересечения объектов в некоей внутренней системе
struct CollisionCategories{
    /// Тело змеи
    static let Snake: UInt32 = 0x1 << 0
    /// Голова змеи
    static let SnakeHead: UInt32 = 0x1 << 1
    /// Яблоко
    static let Apple: UInt32 = 0x1 << 2
    /// Край сцены (экрана)
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    /// Змея
    var snake: Snake?
    
    /// Запускается при запуске сцены (процесс создания базовых объектов)
    override func didMove(to view: SKView) {
        
        // Задний фон
        backgroundColor = #colorLiteral(red: 0.4264220105, green: 0.5855409264, blue: 0.4692757062, alpha: 1)
        
        // Вектор и силы гравитации
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // Поодержка физики в игре
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
        // =========== Поворот против часовой стрелке ===========
        
        /// Нода (объект)
        let counterClockwiseButton = SKShapeNode()
        
        // Задаём форму круга
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        // Позиция на экране
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        
        // Цвет и толщина
        counterClockwiseButton.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        counterClockwiseButton.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        counterClockwiseButton.lineWidth = 10
        
        // Имя объекта для взаимодействия
        counterClockwiseButton.name = "counterClockwiseButton"
        
        // Выводим на экран
        self.addChild(counterClockwiseButton)
        
        // =========== Поворот по часовой стрелке ===========
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockwiseButton.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        clockwiseButton.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)
        
        // Создаём базовые объекты
        createApple()
        createSnake()
    }
    
    /// Создание змеи
    func createSnake() {
        
        // Создание змеи и вывод в центр экрана
        snake?.removeFromParent()
        snake = Snake(atPoint: CGPoint(x: (view?.scene!.frame.midX)!, y: (view?.scene!.frame.midY)!))
        self.addChild(snake!)
    }
    
    /// Нажатие на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /// Перебор всех точек экрана куда коснулся палец
        for touch in touches {
            
            /// Координаты прикосновения
            let touchLocation = touch.location(in: self)
            
            // Проверяем есть ли обьект по этим координатам, и если есть, то не наша ли это кнопка
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            
            // Если это наша кнопка заливаем ее иным цветом
            touchedNode.fillColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            
            // Определяем какая кнопка нажата и поворачиваем в нужную сторону
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    
    /// Отпускаем нажатие на экран
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Повторяем все то же самое для действия, когда палец отрывается от экрана
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            
            // Возвращаем цвет кнопке
            touchedNode.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    /// Вызывается при обрыве нажатия на экран, например если телефон примет звонок и свернет приложение
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    /// Обработка кадров сцены
    override func update(_ currentTime: TimeInterval) {
        // Движение змеи
        snake!.move()
    }
    
    /// Создаем яблоко в случайной точке сцены
    func createApple(){
        // Случайная точка на экране
        print(self.view!.scene!.frame.maxX)
        print(self.view!.scene!.frame.maxY)
        let rand1 = Double.random(in: 0...(Double(view!.scene!.frame.maxX) - 20))
        let rand2 = Double.random(in: 0...(Double(view!.scene!.frame.maxY) - 20))
        let randX = CGFloat(rand1 + 1.0)
        let randY = CGFloat(rand2 + 1.0)
        
        /// Созданное яблоко
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        // Выводим яблоко на экран (сцену)
        self.addChild(apple)
    }
}

// Расширяем сцену
extension GameScene: SKPhysicsContactDelegate {
    
    // ========= Домашнее задание (начало) =========
    
    /// Сообщение о пройгрыше с возможностью начать игру заново
    func losingAlert(_ message: String) {
        let alert = UIAlertController(title: "Финита!", message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ещё разок!", style: .destructive, handler: { (action) in
            self.createSnake()
        }))
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    // ========= Домашнее задание (конец) =========
    
    /// Обработка пересечений
    func didBegin(_ contact: SKPhysicsContact) {
        
        /// Логическая сумма масок сопрекоснувшихся объектов
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        /// Вычитаем из суммы голову змеи и у нас остается маска второго объекта
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        
        // Проверяем что это за второй объект
        switch collisionObject {
        case CollisionCategories.Apple: //проверяем что это яблоко
            
            /// Яблоко это один из двух объектов, используем тернарный оператор что бы вычислить какой
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            
            // Добавляем к змее еще одну секцию
            snake?.addBodyPart()
            
            // Удаляем яблоко
            apple?.removeFromParent()
            
            // Создаем новое яблоко
            createApple()
            
        // Соприкосновение со стенкой экрана (часть домашнего задания)
        case CollisionCategories.EdgeBody:
            losingAlert("Впечатался, друг?")
        default:
            break
        }
    }
}

