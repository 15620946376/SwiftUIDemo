//
//  AppState.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import Foundation

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
        
        var accountBehavior = AccountBehavior.login
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        var email = ""
        var password = ""
        var verifyPassword = ""
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
    }
}


struct User {
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
