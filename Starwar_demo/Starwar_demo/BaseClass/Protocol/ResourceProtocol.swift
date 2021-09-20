//
//  ResourceProtocol.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
import UIKit

protocol ResourceProtocol: class {
    var sections: [ResourcesSection] { get }
    func numberOfItems(at section: Int) -> Int
    func numberOfSections() -> Int
    func item(at indexPath: IndexPath) -> ResourcePresentable?
    func itemSelected(at: IndexPath, navigator: UIViewController)
    func titleForHeader(_ at: Int) -> String
}

extension ResourceProtocol {
    func numberOfItems(at section: Int) -> Int {
        guard section < sections.count else {
            return 0
        }
        
        return sections[section].items.count
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func item(at indexPath: IndexPath) -> ResourcePresentable? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count else {
            return nil
        }
        
        return sections[indexPath.section].items[indexPath.row]
    }
    
    func itemSelected(at: IndexPath, navigator: UIViewController) {
        guard let item = item(at: at) else { return }
        
        if let film = item as? Film,  navigator is FilmsViewController {
            let vc = FilmDetailViewController.instantiate() 
            vc.viewModel = FilmDetailViewModel(with: film.uid)
            navigator.navigationController?.pushViewController(vc, animated: true)
        } else if let character = item as? Characters, navigator is FilmDetailViewController {
            let vc = CharacterDetailViewController.instantiate()
            vc.viewModel = CharacterDetailViewModel(with: character.uid)
            navigator.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func titleForHeader(_ at: Int) -> String {
        sections[at].header
    }
}
