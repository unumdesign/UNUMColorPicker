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

        //color data
        let colorData: [UIColor] = [.white, .black, .blue, .green, .yellow, .red, .cyan, .brown]

        //init view
        let colorPickerViewController = UNUMColorPickerViewController(colors: colorData, initColor: nil)
        colorPickerViewController.colorPickerDelegaet = self

        containerView.addSubview(colorPickerViewController.view)
        addChild(colorPickerViewController)

        //add constraints
        colorPickerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPickerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            colorPickerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            colorPickerViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            colorPickerViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)]
        )
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

