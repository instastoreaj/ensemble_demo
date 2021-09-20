//
//  Characters.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation

struct Characters: Codable {
    var id: String!
    var birthYear: String!
    var eyeColor: String!
    var gender: String!
    var hairColor: String!
    var height: String!
    var homeworld: String!
    var mass: String!
    var name: String!
    var skinColor: String!
    var films: [String] = []
    var species: [String] = []
    var starships: [String] = []
    var vehicles: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "url"
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case gender, height, mass, name, films, species, starships, vehicles, homeworld
    }
}

extension Characters: ResourcePresentable {
    var uid: String {
        return id!
    }
    var titleLabelText: String {
        "Title: \(name!)"
    }
    
    var subtitleLabelText: String {
        """
        Gender: \(gender!)\n
        Height: \(height!) - Mass: \(mass!)\n
        Hair Color: \(hairColor!)\n
        Skin Color: \(skinColor!)
        """
    }
}
