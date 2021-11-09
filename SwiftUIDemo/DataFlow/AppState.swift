//
//  AppState.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import Foundation
import Combine

struct AppState {
    
    var settings = Settings()
    
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
            
            var text: String {
                switch self {
                case .id:
                    return "ID"
                case .name:
                    return "名字"
                case .color:
                    return "颜色"
                case .favorite:
                    return "最爱"
                }
            }
        }
        
        enum AccountBehavior: CaseIterable {
            case register, login
            
            var text: String {
                switch self {
                case .register:
                    return "注册"
                case .login:
                    return "登录"
                }
            }
        }
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
        var logoutRequesting = false
        var checker = AccountChecker()
        var isEmailValid = false
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // 防抖 0.5s
                    .removeDuplicates() // 去除重复元素
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailRequest(email: email).publisher
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                return Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
        }
    }
}


struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
