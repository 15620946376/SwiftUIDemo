//
//  SettingRootView.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView()
                .navigationTitle("设置")
        }
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
