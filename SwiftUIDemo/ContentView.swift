//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/9/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var enableAnimation = false
    
    var body: some View {
        Text("hello world")
    }
}



struct CheckBoxToggleStyle: ToggleStyle {
    
    enum CheckBoxShape:String {
        case circle, square
    }
    
    let shape: CheckBoxShape
    
    init(shape: CheckBoxShape = .circle) {
        self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.\(shape.rawValue).fill" : shape.rawValue)
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
