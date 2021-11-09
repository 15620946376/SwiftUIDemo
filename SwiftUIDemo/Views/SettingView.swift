//
//  SettingView.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/10/24.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
        }
        .alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSection: some View {
        Section("账户") {
            if let user = settings.loginUser {
                Text(user.email)
                if settings.logoutRequesting {
                    Text("注销中...")
                } else {
                    Button("注销") {
                        store.dispatch(.logout)
                    }
                }
            } else {
                Picker("", selection: settingsBinding.checker.accountBehavior) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(.segmented)
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                SecureField("密码", text: settingsBinding.checker.password)
                
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                }
                
                if settings.loginRequesting {
                    Text("登录中...")
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        store.dispatch(
                            .login(email: settings.checker.email, password: settings.checker.password)
                        )
                    }
                }
                
            }
        }
    }
    
    var optionSection: some View {
        Section("选项") {
            Toggle("显示英文名", isOn: settingsBinding.showEnglishName)
            Picker("排序方式", selection: settingsBinding.sorting) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(Store())
    }
}
