//
//  AppCommand.swift
//  SwiftUIDemo
//
//  Created by hanfei on 2021/11/8.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
            .publisher
            .sink(
                receiveCompletion: { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(.accountBehaviorDone(result: .failure(error)))
                    }
                    token.unseal()
                },
                receiveValue: { user in
                    store.dispatch(.accountBehaviorDone(result: .success(user)))
                }
            )
            .seal(in: token)
    }
}

struct LogoutAppCommand: AppCommand {
    let token = SubscriptionToken()
    func execute(in store: Store) {
        LogoutRequest()
            .publisher
            .sink(
                receiveCompletion: { complete in
                    store.dispatch(.logoutDone)
                },
                receiveValue: { value in
                    
                }
            )
            .seal(in: token)
    }
}


class SubscriptionToken {
    var cancellable: AnyCancellable?
    
    func unseal() {
        cancellable = nil
    }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

