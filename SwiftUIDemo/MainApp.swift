//
//  MainApp.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import SwiftUI

struct MainApp: View {
    var body: some View {
        TabView {
            PokemonRootView()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
        }
    }
}

struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp()
    }
}
