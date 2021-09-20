//
//  Species.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation

struct Species: Codable {
    var id: String!
    var averageHeight: String!
    var averageLifespan: String!
    var classification: String!
    var designation: String!
    var eyeColors: String!
    var hairColors: String!
    var homeworld: String!
    var language: String!
    var name: String!
    var skinColors: String!
    var people: [String] = []
    var films: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "url"
        case averageHeight = "average_height"
        case averageLifespan = "average_lifespan"
        case eyeColors = "eye_colors"
        case hairColors = "hair_colors"
        case skinColors = "skin_colors"
        case classification, designation, homeworld, language, name, people, films
    }
}

extension Species: ResourcePresentable {
    var uid: String {
        return id!
    }
    var titleLabelText: String {
        "Title: \(name!)"
    }
    
    var subtitleLabelText: String {
        """
        Language: \(language!)\n
        Classification: \(classification!)\n
        Average Height: \(averageHeight!)\n
        Skin Colors: \(skinColors!)
        """
    }
}
