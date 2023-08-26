//
//  pokeModel.swift
//  ListadoPokemonAPI
//
//  Created by Abel Lazaro on 03/09/22.
//

import Foundation

struct pokeModel: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [pokemon]?
}

struct pokemon: Codable {
    var name: String?
    var url: String?
}

struct pokeDetails: Codable {
    var abilities: [abilities]?
    var height: Int?
    var id: Int?
    var name: String?
    var sprites: image?
    var stats: [stats]?
    var weight: Int?
}

struct abilities: Codable {
    var ability: pokemon?
}

struct image: Codable {
    var front_default: String?
}

struct stats: Codable {
    var base_stat: Int?
}
