//
//  GitHAlertVC.swift
//  GHFollowers
//
//  Created by zgaga on 13/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHAlertVC: UIViewController {

    let containerView = UIView()
    let titleLabel = GitHFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GitHFBodyLabel(textAlignment: .center)
    let actionButton = GitHFButton(backgroundColor: .systemPink, title: "Ok")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    let padding:CGFloat = 20
    let zgBackgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0.75)

    init(alertTitle:String, message:String, buttonTitle:String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        // how to put that into a constant
        view.backgroundColor = zgBackgroundColor

        //original sean ver without a constant
        //view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()



    }
    

    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        // white border around the alert
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)

        ])
    }

    func configureTitleLabel(){
        //adding to the subview
        containerView.addSubview(titleLabel)
        // nil coalescing, unwrap an optional
        titleLabel.text = alertTitle ?? "Sth went wrong, the default"

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant:padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)

        ])

    }

    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)

        ])

    }

    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant:  -12)

        ])
    }

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
