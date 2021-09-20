//
//  BaseViewController.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import Foundation
import UIKit

class BaseViewController : UIViewController, UIViewControllerConfigurable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        bindViewModel()
        updateUI()
    }
    
    func setupComponents() {
        
    }
    
    func bindViewModel() {
        
    }
    
    func updateUI() {
        
    }
}
