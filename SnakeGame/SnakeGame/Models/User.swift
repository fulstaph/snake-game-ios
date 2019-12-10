//
//  User.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

public struct User: Equatable {
    public var login: String
    public var name: String
    public var password: String
    
    init(with dto: UserDTO) {
        login = dto.login
        name = dto.name
        password = dto.password
    }
    
    init(login: String, name: String, password: String) {
        self.login = login
        self.name = name
        self.password = password
    }
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.login == rhs.login && lhs.password == rhs.password
    }}
