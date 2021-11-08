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
                Button("注销") {
                    print("注销")
                }
            } else {
                Picker("", selection: settingsBinding.accountBehavior) {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(.segmented)
                TextField("电子邮箱", text: settingsBinding.email)
                SecureField("密码", text: settingsBinding.password)
                
                if settings.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                
                if settings.loginRequesting {
                    Text("登录中...")
                } else {
                    Button(settings.accountBehavior.text) {
                        store.dispatch(
                            .login(email: settings.email, password: settings.password)
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
