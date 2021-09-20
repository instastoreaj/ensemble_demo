//
//  NSObject+Protocol+Extension.swift
//  Starwar_demo
//
//  Created by Mac on 9/17/21.
//

import Foundation
import UIKit

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}

protocol Nibable: NSObjectProtocol {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension Nibable {
    static var nibName: String {
        return className
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
