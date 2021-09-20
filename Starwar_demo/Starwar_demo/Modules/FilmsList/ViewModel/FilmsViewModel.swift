//
//  FilmsViewModel.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation

enum ViewModelState {
    case stop
    case loading
    case error(Error)
}

class FilmsViewModel: BaseModel {
    var dataSource: Observable<[ResourcesSection]> = Observable([])
    var appState: Observable<ViewModelState> = Observable(.stop)
    var currentState = ViewModelState.stop
    private var films: [Film] = []
    private var results: [ResourcesSection] = []
    private var originResults: [ResourcesSection] = []
    
    override func fetchData() {
        self.currentState = .loading
        self.updateState()
        
        NetworkManager.sharedInstance.getFilmsList { [weak self] data in
            if let films = data.films, films.count > 0 {
                self?.currentState = .stop
                self?.updateState()
                self?.films = films
                self?.results.append(ResourcesSection(header: "Films", items: films))
                self?.originResults = self?.results ?? []
                self?.dataSource.value = self?.results ?? []

            }
        } failHandler: { [weak self] error in
            self?.currentState = .error(error)
            self?.updateState()
        }
    }
    
    override func updateState() {
        self.appState.value = self.currentState
    }
    
    func search(text: String) {
        if !text.isEmpty {
            if originResults.count > 0 {
                let searchResult = originResults[0].items.filter { film in
                    let tmp: NSString = film.titleLabelText as NSString
                    let range = tmp.range(of: text, options: NSString.CompareOptions.caseInsensitive)
                    return range.location != NSNotFound
                }
                results.removeAll()
                results.append(ResourcesSection(header: "Films", items: searchResult))
                self.dataSource.value =  results
            }
        } else {
            results = originResults
            self.dataSource.value =  results
        }
    }
}

extension FilmsViewModel: ResourceProtocol {
    var sections: [ResourcesSection] {
        return results
    }
}
