//
//  FilmDetailViewModel.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation

class FilmDetailViewModel: BaseModel {
    var dataSource: Observable<[ResourcesSection]> = Observable([])
    var appState: Observable<ViewModelState> = Observable(.stop)
    var currentState = ViewModelState.stop
    private var films: [Film] = []
    private var characters: [Characters] = []
    private var planets: [Planets] = []
    private var species: [Species] = []
    private var starships: [Starship] = []
    private var vehicles: [Vehicle] = []
    private var results: [ResourcesSection] = []
    private var film: Film?
    
    var path: String
    
    override func fetchData() {
        self.currentState = .loading
        self.updateState()
        NetworkManager.sharedInstance.getDetail(path: path, type: Film.self) { [weak self] data in
            self?.currentState = .stop
            self?.film = data
            if let validFilm = self?.film {
                self?.films.append(validFilm)
                self?.results.append(ResourcesSection(header: "Film Detail", items: self?.films ?? []))
                self?.fetchDetail()
            }
        } failHandler: { [weak self] error in
            self?.currentState = .error(error)
            self?.updateState()
        }
    }
    
    override func updateState() {
        self.appState.value = self.currentState
    }
    
    init(with path: String) {
        self.path = path
        dataSource = Observable([])
    }
    
    func fetchDetail() {
        let group = DispatchGroup()
        var storedError: Error?
        
        if  let characters = film?.characters, characters.count > 0 {
            characters.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Characters.self) { [weak self] data in
                    self?.characters.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        if  let planets = film?.planets, planets.count > 0 {
            planets.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Planets.self) { [weak self] data in
                    self?.planets.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        if  let starShips = film?.starships, starShips.count > 0 {
            starShips.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Starship.self) { [weak self] data in
                    self?.starships.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        if  let vehicles = film?.vehicles, vehicles.count > 0 {
            vehicles.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Vehicle.self) { [weak self] data in
                    self?.vehicles.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        if  let species = film?.species, species.count > 0 {
            species.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Species.self) { [weak self] data in
                    self?.species.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            if let error = storedError {
                self.currentState = .error(error)
                self.updateState()
            } else {
                if self.characters.count > 0 { self.results.append(ResourcesSection(header: "Characters", items: self.characters)) }
                if self.planets.count > 0 { self.results.append(ResourcesSection(header: "Planets", items: self.planets)) }
                if self.starships.count > 0 { self.results.append(ResourcesSection(header: "Starship", items: self.starships)) }
                if self.vehicles.count > 0 { self.results.append(ResourcesSection(header: "Vehicle", items: self.vehicles)) }
                if self.species.count > 0 { self.results.append(ResourcesSection(header: "Species", items: self.species)) }
                self.currentState = .stop
                self.updateState()
                self.dataSource.value = self.results
            }
        }
    }
}

extension FilmDetailViewModel: ResourceProtocol {
    var sections: [ResourcesSection] {
        return results
    }
}
