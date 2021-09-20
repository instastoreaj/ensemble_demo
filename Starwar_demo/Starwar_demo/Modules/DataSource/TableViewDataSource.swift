//
//  TableViewDataSource.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject {
    weak var delegate: ResourceProtocol?
    var view: UIViewController
    
    init(delegate: ResourceProtocol?, view: UIViewController) {
        self.delegate = delegate
        self.view = view
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension TableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        delegate?.numberOfSections() ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfItems(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = delegate?.item(at: indexPath) else {
            fatalError("Item not exists")
        }
        
        let cell = tableView.dequeueReusableCell(with: FilmViewCell.self, for: indexPath)
        cell.configure(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.numberOfSections() ?? 1 > 1 ? 50: 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        sectionView.backgroundColor = .gray
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width - 20*2, height: sectionView.frame.height))
        label.backgroundColor = UIColor.clear
        label.textColor = .black
        label.text = delegate?.titleForHeader(section)
        sectionView.addSubview(label)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.itemSelected(at: indexPath, navigator: view)
    }
}
