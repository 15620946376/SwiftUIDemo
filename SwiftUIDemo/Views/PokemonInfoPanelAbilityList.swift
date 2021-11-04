//
//  PokemonInfoPanelAbilityList.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/10/24.
//

import SwiftUI

extension PokemonInfoPanel {
    struct AbilityList: View {
        
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if let abilityModels = abilityModels {
                    ForEach(abilityModels) {
                        Text($0.name)
                            .font(.subheadline)
                            .foregroundColor(model.color)
                        Text($0.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
