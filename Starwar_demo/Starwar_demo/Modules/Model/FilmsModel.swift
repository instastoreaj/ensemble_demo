//
//  MoviesModel.swift
//  Starwar_demo
//
//  Created by Mac on 9/15/21.
//

import Foundation

struct FilmsModel : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let films : [Film]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case films = "results"
    }
}

struct Film : Codable {
    let characters : [String]?
    let created : String?
    let director : String?
    let edited : String?
    let episodeId : Int?
    let openingCrawl : String?
    let planets : [String]?
    let producer : String?
    let releaseDate : String?
    let species : [String]?
    let starships : [String]?
    let title : String?
    let url : String?
    let vehicles : [String]?

    enum CodingKeys: String, CodingKey {
        case characters = "characters"
        case created = "created"
        case director = "director"
        case edited = "edited"
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case planets = "planets"
        case producer = "producer"
        case releaseDate = "release_date"
        case species = "species"
        case starships = "starships"
        case title = "title"
        case url = "url"
        case vehicles = "vehicles"
    }
}

extension Film: ResourcePresentable {
    var uid: String {
        return url!
    }
    
    var titleLabelText: String {
        "Title: \(title!)"
    }
    
    var subtitleLabelText: String {
        """
        Description: \(openingCrawl ?? "")\n
        Episode: \(String(episodeId ?? 0))\n
        Director: \(director!)\n
        Producer: \(producer!)\n
        ReleaseDate: \(releaseDate!)
        """
    }
}
