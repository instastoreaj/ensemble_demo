//
//  ResourcePresentable.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation

protocol ResourcePresentable {
    var uid: String { get }
    var titleLabelText: String { get }
    var subtitleLabelText: String { get }
}
