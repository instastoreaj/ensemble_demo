//
//  Observable.swift
//  Starwar_demo
//
//  Created by Mac on 9/15/21.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
