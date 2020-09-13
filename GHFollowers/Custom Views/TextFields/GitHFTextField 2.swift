//
//  GitHFTextField.swift
//  GHFollowers
//
//  Created by zgaga on 30/06/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHFTextField: UITextField {



    override init(frame: CGRect) {
        super.init(frame:frame)
        // configure trzeba odalic !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        textColor = .label // for color of the txt, black in whitemode, white in dark
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        keyboardType = .default //rodzaj klaw w polu txt
        returnKeyType = .go

        placeholder = "Enter a username"
    }

}
