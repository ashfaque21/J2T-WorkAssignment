//
//  UIViewController+Message.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 06/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorWith(_ title: String?, message: String) {
           let alertController = UIAlertController(title: title,
                                                   message: message,
                                                   preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           present(alertController, animated: true, completion: nil)
       }
}
