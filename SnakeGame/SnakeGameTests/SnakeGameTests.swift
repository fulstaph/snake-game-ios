//
//  SnakeGameTests.swift
//  SnakeGameTests
//
//  Created by Svetlana Timofeeva on 10/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import XCTest


class SnakeGameTests: XCTestCase {

    var service = NetworkService()
    var users: [User] = {
        var users: [User] = [
            User(login: "admin", name: "George", password: "qwe"),
            User(login: "superman", name: "Clark", password: "007"),
            User(login: "beatle", name: "Paul", password: "123")
        ]
        return users
    }()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGotUsersFromFirebase() {
        var downloadedUsers: [User]?
        let group = DispatchGroup()
        group.enter()
        service.loadUsers(completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    downloadedUsers = users
                    group.leave()
                case .failure(let error):
                    XCTFail("didnt get users from server")
                    //group.leave()
                }
            }
        })
        //group.wait()
        group.notify(queue: DispatchQueue.main) {
            XCTAssert(downloadedUsers == self.users, "did we get em")

        }
    }
}
