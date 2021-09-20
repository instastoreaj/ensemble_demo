//
//  UIViewConfigurable.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation

protocol Configurable {
    func configure(item: Any)
}

protocol UIViewControllerConfigurable {
    func setupComponents()
    func bindViewModel()
    func updateUI()
}

