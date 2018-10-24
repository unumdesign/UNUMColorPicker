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

        let borderColor = colorValue == .white ? .lightGray : colorValue

        borderView.backgroundColor = colorValue
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = borderView.bounds.width / 2
        borderView.layer.borderColor = borderColor.cgColor
        fillView.layer.borderColor = colorValue.cgColor
        fillView.layer.borderWidth = 1
        fillView.layer.cornerRadius = fillView.bounds.width / 2
        if selected {
            fillView.backgroundColor = colorValue
        } else {
            fillView.backgroundColor = .white
        }
    }

}
