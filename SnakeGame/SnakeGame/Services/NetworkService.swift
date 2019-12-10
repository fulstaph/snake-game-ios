//
//  NetworkService.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation
import UIKit

public final class NetworkService {
    private let session: URLSession
    
    private let queue = DispatchQueue(label: "game-service", qos: .default, attributes: .concurrent)
    
    private let fb_api_key = "AIzaSyCxjJYETVpMRP55a2QpB2cdp7k7iTmruZk"
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    public func loadUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        let url = "https://snakegame-522a.firebaseio.com/users.json?" + "avvrdd_token=" + fb_api_key
        let dataURL = URL(string: url)!
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                let usersDTOs = try JSONDecoder().decode([String : UserDTO].self, from: data!)
                var users: [User] = []
                for user in usersDTOs.values {
                    users.append(User(with: user))
                }
                completion(.success(users))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
