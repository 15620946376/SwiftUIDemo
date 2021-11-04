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
    }
    
    var accountSection: some View {
        Section("账户") {
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
            
            Button(settings.accountBehavior.text) {
                print(".....")
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
