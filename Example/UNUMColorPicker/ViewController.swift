//
//  ViewController.swift
//  UNUMColorPicker
//
//  Created by zhaoli1211 on 10/24/2018.
//  Copyright (c) 2018 zhaoli1211. All rights reserved.
//

import UIKit
import UNUMColorPicker

class ViewController: UIViewController {

    @IBOutlet var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //color data
        let colorData: [UIColor] = [.white, .black, .blue, .green, .yellow, .red, .cyan, .brown]

        //init view
        let bundle = Bundle(for: UNUMColorPickerView.self)
        let nib = UINib(nibName: "UNUMColorPickerView", bundle: bundle)
        let colorPickerView = nib.instantiate(withOwner: self, options: nil).first as! UNUMColorPickerView

        containerView.addSubview(colorPickerView)

        //add constraints
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            colorPickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            colorPickerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            colorPickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)])

        
        colorPickerView.setup(colors: colorData, initColor: nil)

        colorPickerView.colorPickerDelegaet = self
    }
}

//MARK: UNUMColorPickerDelegate
extension ViewController: UNUMColorPickerDelegate {
    func save() {

    }

    func cancel() {
        
    }

    func didSet(color: UIColor) {
        self.view.backgroundColor = color
    }
}

