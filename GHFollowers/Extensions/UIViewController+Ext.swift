//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by zgaga on 17/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {

    func presentGitHAlertOnMainThread(title:String, message: String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GitHAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url:URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true )
    }

    func showLoadingView(){

        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        // ADD SUBVIEW TO THE VIEW !!!!!!!!!!!!!!!!!!!
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil

        }



    }

    func showEmptyStateView(with message:String, in view:UIView){
        let emptyStateView = GitHEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)


    }

}
