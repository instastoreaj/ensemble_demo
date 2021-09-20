//
//  CharacterDetailViewModel.swift
//  Starwar_demo
//
//  Created by Mac on 9/20/21.
//

import Foundation

class CharacterDetailViewModel: BaseModel {
    var dataSource: Observable<[ResourcesSection]> = Observable([])
    var appState: Observable<ViewModelState> = Observable(.stop)
    var currentState = ViewModelState.stop
    private var characters: [Characters] = []
    private var films: [Film] = []
    private var species: [Species] = []
    private var starships: [Starship] = []
    private var vehicles: [Vehicle] = []
    private var results: [ResourcesSection] = []
    private var character: Characters?
    
    var path: String
    
    override func fetchData() {
        self.currentState = .loading
        self.updateState()
        NetworkManager.sharedInstance.getDetail(path: path, type: Characters.self) { [weak self] data in
            self?.currentState = .stop
            self?.character = data
            if let validCharacter = self?.character {
                self?.characters.append(validCharacter)
                self?.results.append(ResourcesSection(header: "Character Detail", items: self?.characters ?? []))
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
        
        if  let films = character?.films, films.count > 0 {
            films.forEach {
                group.enter()
                NetworkManager.sharedInstance.getDetail(path: $0, type: Film.self) { [weak self] data in
                    self?.films.append(data)
                    group.leave()
                } failHandler: { error in
                    storedError = error
                    group.leave()
                }
            }
        }
        
        if  let starShips = character?.starships, starShips.count > 0 {
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
        
        if  let vehicles = character?.vehicles, vehicles.count > 0 {
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
        
        if  let species = character?.species, species.count > 0 {
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
                if self.films.count > 0 { self.results.append(ResourcesSection(header: "Films", items: self.films)) }
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

extension CharacterDetailViewModel: ResourceProtocol {
    var sections: [ResourcesSection] {
        return results
    }
}
