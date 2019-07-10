//
//  UIViewController+UIAlertController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

extension UIViewController {
    func showError(title: String,
                   message: String,
                   actionTitle: String = "OK",
                   handler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            handler?()
        })
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
