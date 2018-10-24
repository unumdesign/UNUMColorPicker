//
//  UNUMColorPickerView.swift
//  UNUMColorPicker
//
//  Created by Li Zhao on 10/24/18.
//

import UIKit

public protocol UNUMColorPickerDelegate: class {
    func didSet(color: UIColor)
    func save()
    func cancel()
}

public class UNUMColorPickerView: UIView {

    @IBOutlet var colorCollectionView: UICollectionView!
    //collection view data dource
    private var colors: [UIColor]!
    private let cellIdentifier = "ColorEditorCollectionViewCell"

    //delegate: communicate with outside
    public var colorPickerDelegaet: UNUMColorPickerDelegate?

    fileprivate var initColor: UIColor!
    fileprivate var selectedColor: UIColor!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(colors: [UIColor], initColor: UIColor?) {
        self.colors = colors
        // set init color, if nil use the first color from array
        self.initColor = initColor == nil ? colors.first : initColor
        selectedColor = self.initColor
        setupCollectionView()
    }

    private func setupCollectionView() {
        let bundle = Bundle(for: UNUMColorPickerView.self)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        colorCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)

        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        colorPickerDelegaet?.save()
    }

    @IBAction func cancelAction(sender: AnyObject) {
        colorPickerDelegaet?.cancel()
    }
}

extension UNUMColorPickerView: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ColorEditorCollectionViewCell
        let color = colors[indexPath.row]
        cell.setupColorButton(colorValue: color, selected: selectedColor == color)

        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
}

extension UNUMColorPickerView: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colorPickerDelegaet?.didSet(color: colors[indexPath.row])
        selectedColor = colors[indexPath.row]
        collectionView.reloadData()
    }
}
