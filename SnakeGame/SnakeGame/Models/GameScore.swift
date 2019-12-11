//
//  GameScore.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 11/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation



public final class GameScore {
    static let shared = GameScore()
    private(set) var score: Int = 0
    private init() {}
    
    var data: [Int] = []
    
    public func increaseScore() {
        score += 10
    }
    public func reset() {
        score = 0
    }
    
    public func addRecordToTheTop() {
        data.append(score)
        data.sort { $0 > $1 }
    }
}
