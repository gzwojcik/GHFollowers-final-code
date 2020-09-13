//
//  GitHFBodyLabel.swift
//  GHFollowers
//
//  Created by zgaga on 13/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHFBodyLabel: UILabel {

   override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     init(textAlignment:NSTextAlignment){
         super.init(frame: .zero)
         self.textAlignment = textAlignment
         configure()
     }

     private func configure(){
         // .label is black in light mode, white in darkj m
         textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
         adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
         lineBreakMode = .byWordWrapping
         translatesAutoresizingMaskIntoConstraints = false


     }


}
