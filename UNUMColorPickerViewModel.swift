//
//  UNUMColorPickerViewModel.swift
//  
//
//  Created by Patrick Flanagan on 10/26/18.
//

import Foundation

class UNUMColorPickerViewModel {

    let colors: [UIColor]
    var selectedColor: UIColor

    init(colors: [UIColor], selectedColor: UIColor? = nil) {
        self.colors = colors
        self.selectedColor = selectedColor ?? colors.first ?? .clear
    }
}
