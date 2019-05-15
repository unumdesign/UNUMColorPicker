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

        borderView.layer.borderWidth = isWhiteColor ? 0.5 : 3
        borderView.layer.cornerRadius = borderView.bounds.width / 2
        borderView.layer.borderColor = isWhiteColor ? UIColor.lightGray.cgColor : colorValue.cgColor
        borderView.backgroundColor = selected ? colorValue : .white

        fillView.isHidden = !isWhiteColor
        fillView.layer.borderWidth = selected ? 0 : 0.5
        fillView.layer.borderColor = UIColor.lightGray.cgColor
        fillView.layer.cornerRadius = fillView.bounds.width / 2
    }
}
