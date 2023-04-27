//
//  UserViewModelOutput.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan on 27.04.2023.
//

import Foundation

protocol UserViewModelOutput : AnyObject{
    func updateView(name: String, email: String, username : String)
}
