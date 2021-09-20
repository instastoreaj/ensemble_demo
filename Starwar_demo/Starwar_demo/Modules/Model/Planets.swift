//
//  Planets.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation

struct Planets: Codable {
    var id: String!
    var climate: String!
    var diameter: String!
    var gravity: String!
    var name: String!
    var orbitalPeriod: String!
    var population: String!
    var rotationPeriod: String!
    var surfaceWater: String!
    var terrain: String!
    var films: [String] = []
    var residents: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "url"
        case orbitalPeriod = "orbital_period"
        case rotationPeriod = "rotation_period"
        case surfaceWater = "surface_water"
        case climate, diameter, gravity, name, population, terrain, films, residents
    }
}

extension Planets: ResourcePresentable {
    var uid: String {
        return id!
    }
    var titleLabelText: String {
        "Title: \(name!)"
    }
    
    var subtitleLabelText: String {
        """
        Climate: \(climate!)\n
        Population: \(population!)\n
        Diameter: \(diameter!)\n
        Terrain: \(terrain!)
        """
    }
}
