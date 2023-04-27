//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan on 27.04.2023.
//

import Foundation

class UserViewModel {
    
    private let userService : UserService
    weak var output : UserViewModelOutput?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetschUsers(){
        
        userService.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(name: user.name, email: user.email, username: user.username)
            case .failure(_):
                self?.output?.updateView(name: "No User", email: "", username: "")
            }
        }
    }
}
