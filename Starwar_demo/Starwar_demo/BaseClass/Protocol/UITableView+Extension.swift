//
//  UITableView+Extension.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) where T: Nibable {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func register<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type) where T: Nibable {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with headerFooterViewType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}

extension UITableViewCell {
    static var identifier: String {
        return className
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return className
    }
}
