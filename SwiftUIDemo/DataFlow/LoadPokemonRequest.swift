//
//  LoadPokemonRequest.swift
//  SwiftUIDemo
//
//  Created by 韩菲菲 on 2021/11/9.
//

import Foundation
import Combine

struct LoadPokemonRequest {
    let id: Int
    
    let appDecoder = JSONDecoder()
    
    var publisher: AnyPublisher<PokemonViewModel, AppError> {
        pokemonPublisher(id)
            .flatMap {
                self.speciesPublisher($0)
            }
            .map {
                PokemonViewModel(pokemon: $0, species: $1)
            }
            .mapError {
                AppError.networkingFailed($0)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func pokemonPublisher(_ id: Int) -> AnyPublisher<Pokemon, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    func speciesPublisher(_ pokemon: Pokemon) -> AnyPublisher<(Pokemon, PokemonSpecies), Error> {
        URLSession.shared.dataTaskPublisher(for: pokemon.species.url)
            .map { $0.data }
            .decode(type: PokemonSpecies.self, decoder: appDecoder)
            .map { (pokemon, $0) }
            .eraseToAnyPublisher()
    }
}
