//
//  OverviewResourcePresentable.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
import UIKit

protocol OverviewResourcePresentable {
    var titleLabel: UILabel! {set get}
    var subTitleLabel: UILabel! {set get}
}

extension OverviewResourcePresentable {
    func map(resource: ResourcePresentable?) {
        guard let resource = resource else { return }
        titleLabel?.text = resource.titleLabelText
        subTitleLabel?.text = resource.subtitleLabelText
    }
}
