//
//  UNUMColorPickerViewModel.swift
//  
//
//  Created by Patrick Flanagan on 10/26/18.
//

import Foundation

// The point of the viewModel is to handle any sort of data conversion that needs to happen between the raw data it receives and the data that the view needs to display the data. This is a pretty poor example since the view can already handle colors. However, this at least contains the logic surrounding how to handle the nil case of `selectedColor`, which the view shouldn't have to know.
class UNUMColorPickerViewModel {

    let colors: [UIColor]
    let initialColor: UIColor
    var selectedColor: UIColor

    init(colors: [UIColor], initialColor: UIColor) {
        self.colors = colors
        self.initialColor = initialColor
        self.selectedColor = initialColor
    }
}
