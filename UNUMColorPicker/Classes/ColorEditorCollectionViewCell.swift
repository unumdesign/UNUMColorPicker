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

        borderView.backgroundColor = colorValue
        borderView.layer.cornerRadius = borderView.bounds.width / 2
        borderView.layer.borderWidth = 0.5
        borderView.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).cgColor

        fillView.backgroundColor = .clear
        fillView.layer.cornerRadius = fillView.bounds.width / 2
        fillView.layer.borderColor = UIColor(white: 0.975, alpha: 1.0).cgColor

        fillView.layer.borderWidth = selected ? 3 : 0
    }
}
