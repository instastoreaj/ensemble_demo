//
//  Vehicles.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
struct Vehicle: Codable {
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
    var vehicleClass: String!
    
    enum CodingKeys: String, CodingKey {
        case id = "url"
        case cargoCapacity = "cargo_capacity"
        case costInCredits = "cost_in_credits"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case consumables, crew, length, manufacturer, model, name, passengers, films, pilots
    }
}

extension Vehicle: ResourcePresentable {
    var uid: String {
        return id!
    }
    var titleLabelText: String {
        "Title: \(name!)"
    }
    
    var subtitleLabelText: String {
        """
        Model: \(model!)\n
        Consumables: \(consumables!)\n
        Manufacturer: \(manufacturer!)\n
        Max Atmosphering Speed: \(maxAtmospheringSpeed!)
        """
    }
}
