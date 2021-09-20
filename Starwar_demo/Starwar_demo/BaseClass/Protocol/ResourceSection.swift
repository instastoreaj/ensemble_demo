//
//  ResourceSection.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation

struct ResourcesSection {
    var header: String
    var items: [Item]
}

extension ResourcesSection {
    typealias Item = ResourcePresentable
    
    init(original: ResourcesSection, items: [Item]) {
        self = original
        self.items = items
    }
}
