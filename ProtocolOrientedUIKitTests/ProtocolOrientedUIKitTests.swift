//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Furkan on 27.04.2023.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {
 
    private var userViewModel : UserViewModel!
    private var userService : MockUserService!
    private var output : MockUserViewModelOutput!
    
    override func setUpWithError() throws {
        userService = MockUserService()
        userViewModel = UserViewModel(userService: userService)
        output = MockUserViewModelOutput()
        userViewModel.output = output
    }

    override func tearDownWithError() throws {
        
        userService = nil
        userViewModel = nil
        
    }

    func testUpdateView_whenAPISuccess_showEmailNameUsername() throws {
        let mockUser = User(id: 1, name: "Furkan", username: "furkankeskin", email: "furkan@gmail.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        
        userService.fetchUserMockResult = .success(mockUser)
        
        userViewModel.fetschUsers()
        
        XCTAssertEqual(output.updateViewArray.first?.username, "furkankeskin")
    }
    
    func testUpdateView_whenAPIFailure_showNoUser() throws {
        userService.fetchUserMockResult = .failure(NSError())
        userViewModel.fetschUsers()
        
        XCTAssertEqual(output.updateViewArray.first?.name, "No User")
    }

}

class MockUserService : UserService{
    var fetchUserMockResult : Result<ProtocolOrientedUIKit.User, Error>?
    func fetchUser(completion: @escaping (Result<ProtocolOrientedUIKit.User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
    
    
}

class MockUserViewModelOutput : UserViewModelOutput{
    var updateViewArray : [(name: String, email: String, username: String)] = []
    func updateView(name: String, email: String, username: String) {
        updateViewArray.append((name, email, username))
    }
}
