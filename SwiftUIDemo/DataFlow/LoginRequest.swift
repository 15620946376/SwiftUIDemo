//
//  LoginRequest.swift
//  SwiftUIDemo
//
//  Created by hanfei on 2021/11/8.
//

import Foundation
import Combine

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                if self.password == "password" {
                    promise(.success(User(email: self.email, favoritePokemonIDs: [])))
                } else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


struct LogoutRequest {
    var publisher: AnyPublisher<Bool, AppError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                promise(.success(true))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct EmailRequest {
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "111@163.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
