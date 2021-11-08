//
//  Store.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/2.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
}
