//
//  AppAction.swift
//  SwiftUIDemo
//
//  Created by hanfei on 2021/11/8.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
}


