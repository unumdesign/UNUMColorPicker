//
//  ColorEditorCollectionViewCell.swift
//  UNUM
//
//  Created by Li Zhao on 8/1/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class ColorEditorCollectionViewCell: UICollectionViewCell {

    @IBOutlet var borderView: UIView!
    @IBOutlet var fillView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupColorButton(colorValue: UIColor, selected: Bool) {
        self.layoutIfNeeded()

        let isWhiteColor = colorValue == .white

        borderView.layer.borderWidth = 0.5
        borderView.layer.cornerRadius = borderView.bounds.width / 2
        borderView.layer.borderColor = isWhiteColor ? UIColor.lightGray.cgColor : colorValue.cgColor
        fillView.layer.borderColor = colorValue.cgColor
        fillView.backgroundColor = colorValue
        fillView.layer.borderWidth = isWhiteColor ? 2 : 1
        fillView.layer.cornerRadius = fillView.bounds.width / 2
        if selected {
            borderView.layer.borderWidth = isWhiteColor ? 0.5 : 2
            fillView.layer.borderColor = isWhiteColor ? UIColor.lightGray.cgColor : colorValue.cgColor
            borderView.backgroundColor = .white
        } else {
            borderView.backgroundColor = colorValue
        }
    }
}
