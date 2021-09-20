//
//  Starships.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation

struct Starship: Codable {
    var id: String!
    var cargoCapacity: String!
    var consumables: String!
    var costInCredits: String!
    var crew: String!
    var length: String!
    var manufacturer: String!
    var maxAtmospheringSpeed: String!
    var model: String!
    var name: String!
    var passengers: String!
    var films: [String] = []
    var pilots: [String] = []
    var mglt: String!
    var hyperdriveRating: String!
    var starshipClass: String!
    
    
    enum CodingKeys: String, CodingKey {
        case id = "url"
        case mglt = "MGLT"
        case cargoCapacity = "cargo_capacity"
        case costInCredits = "cost_in_credits"
        case hyperdriveRating = "hyperdrive_rating"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case starshipClass = "starship_class"
        case consumables, crew, length, manufacturer, model, name, passengers, films, pilots
    }
}

extension Starship: ResourcePresentable {
    var uid: String {
        return id!
    }
    var titleLabelText: String {
        "Title: \(name ?? "Unknown")"
    }
    
    var subtitleLabelText: String {
        """
        Model: \(model ?? "")\n
        Consumables: \(consumables ?? "")\n
        Manufacturer: \(manufacturer ?? "")\n
        Max Atmosphering Speed: \(maxAtmospheringSpeed ?? "")
        """
    }
}
