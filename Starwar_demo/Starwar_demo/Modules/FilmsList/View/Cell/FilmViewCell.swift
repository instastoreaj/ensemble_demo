//
//  FilmViewCell.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import UIKit

class FilmViewCell: UITableViewCell, Nibable, Configurable, OverviewResourcePresentable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: Any) {
        map(resource: item as? ResourcePresentable)
    }
}
