//
//  User.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public struct User {
    public var login: String
    public var name: String
    public var password: String
    
    init(with dto: UserDTO) {
        login = dto.login
        name = dto.name
        password = dto.password
    }
}
