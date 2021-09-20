//
//  AppAlert.swift
//  Starwar_demo
//
//  Created by Mac on 9/19/21.
//

import Foundation
import UIKit

public class AppAlert: NSObject {
  
    func show(to: UIViewController, title:String, message:String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes",
                                       style: .default,
                                       handler: handler))
        to.present(alertController, animated: true)
    }

    func show(to: UIViewController, title:String, message:String, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes",
                                       style: .default,
                                       handler: okHandler))
        alertController.addAction(UIAlertAction(title: "No",
                                                style: .default,
                                                handler: cancelHandler))

        to.present(alertController, animated: true)
    }
}
