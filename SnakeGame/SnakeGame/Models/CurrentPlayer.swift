//
//  CurrentPlayer.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 11/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public final class CurrentPlayerSingleton {
    var player: User = User(login: "", name: "", password: "")
    static let shared = CurrentPlayerSingleton()
    private init() {
    }
}
