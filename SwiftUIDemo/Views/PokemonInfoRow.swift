//
//  PokemonInfoRow.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/10/18.
//

import SwiftUI

struct PokemonInfoRow: View {
    
    let model: PokemonViewModel
    let expanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            
            
            HStack {
                Spacer()
                Button(action: { print("fav") }) {
                    Image(systemName: "star")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30.0, height: 30.0)
                }
                Button(action: {}) {
                    Image(systemName: "chart.bar")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30.0, height: 30.0)
                }
                Button(action: {}) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 30.0, height: 30.0)
                }
            }
            .frame(height: expanded ? 30.0 : 0.0)
            .opacity(expanded ? 1.0 : 0.0)
            .padding(.bottom, 12)
        }
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [.white, model.color],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        )
        .padding(.horizontal)
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 25), expanded: false)
        }
    }
}
