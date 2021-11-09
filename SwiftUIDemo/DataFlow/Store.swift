//
//  Store.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    var disposeBag = [AnyCancellable]()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid.sink { value in
            self.dispatch(.emailValid(valid: value))
        }.store(in: &disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[Action]:\(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
            print("[AppCommand]:\(action)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        case .login(let email, let password):
            guard appState.settings.loginRequesting == false else {
                break
            }
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .accountBehaviorDone(let result):
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        case .logout:
            guard appState.settings.logoutRequesting == false else {
                break
            }
            appState.settings.logoutRequesting = true
            appCommand = LogoutAppCommand()
        case .logoutDone:
            appState.settings.logoutRequesting = false
            appState.settings.loginUser = nil
        case .emailValid(let valid):
            appState.settings.isEmailValid = valid
        }
        return (appState, appCommand)
    }
}
