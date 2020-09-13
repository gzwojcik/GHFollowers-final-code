//
//  GitHSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by zgaga on 27/07/2020.
//  Copyright © 2020 Hime Electronics Int. All rights reserved.
//

import UIKit

class GitHSecondaryTitleLabel: UILabel {

   override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   init(fontSize:CGFloat){
       super.init(frame: .zero)
    font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
       configure()
   }

   private func configure(){
       // .label is black in light mode, white in darkj m
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false


   }



}
