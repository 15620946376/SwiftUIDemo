//
//  PokemonList.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/10/19.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(PokemonViewModel.all) { pokemon in
                    PokemonInfoRow(
                        model: pokemon,
                        expanded: expandingIndex == pokemon.id
                    )
                        .onTapGesture {
                            withAnimation {
                                if expandingIndex == pokemon.id {
                                    expandingIndex = nil
                                } else {
                                    expandingIndex = pokemon.id
                                }
                            }
                        }
                }
            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }
//                .edgesIgnoringSafeArea(.bottom)
//        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
