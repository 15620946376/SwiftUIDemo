//
//  PokemonInfoPanel.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/10/21.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    let model: PokemonViewModel
    
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: 1)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(
            EdgeInsets(
                top: 12,
                leading: 30,
                bottom: 30,
                trailing: 30
            )
        )
        .blurBackground(style: .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPanel {
    struct Header: View {
        
        let model: PokemonViewModel
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        var nameSpecies: some View {
            VStack(spacing: 10) {
                VStack {
                    Text(model.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(model.color)
                    Text(model.nameEN)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(model.color)
                }
                Text(model.genus)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
        var verticalDivider: some View {
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 1, height: 44)
                .opacity(0.1)
        }
        var bodyStatus: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("身高")
                        .foregroundColor(.gray)
                    Text(model.height)
                        .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .foregroundColor(.gray)
                    Text(model.weight)
                        .foregroundColor(model.color)
                }
            }
            .font(.system(size: 11))
        }
        var typeInfo: some View {
            HStack {
                ForEach(model.types) { type in
                    Text(type.name)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .frame(height: 14)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(type.color)
                        )
                }
            }
        }
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: PokemonViewModel.sample(id: 1))
    }
}
