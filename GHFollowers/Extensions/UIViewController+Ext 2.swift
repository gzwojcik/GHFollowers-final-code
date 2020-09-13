//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by zgaga on 17/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentGitHAlertOnMainThread(title:String, message: String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GitHAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
