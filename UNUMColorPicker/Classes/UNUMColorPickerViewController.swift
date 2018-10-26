//
//  UNUMColorPickerViewController.swift
//  UNUMColorPicker
//
//  Created by Patrick Flanagan on 10/25/18.
//

import UIKit

public protocol UNUMColorPickerDelegate: class {
    func didSet(color: UIColor)
    func save()
    func cancel()
}

public class UNUMColorPickerViewController: UIViewController {

    @IBOutlet var colorCollectionView: UICollectionView!

    public var delegate: UNUMColorPickerDelegate?

    private var viewModel: UNUMColorPickerViewModel!
    private let cellIdentifier = "ColorEditorCollectionViewCell"

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public convenience init(colors: [UIColor], initiallySelectedColor: UIColor? = nil) {
        let bundle = Bundle(for: UNUMColorPickerViewController.self)
        self.init(nibName: "UNUMColorPickerViewController", bundle: bundle)
        self.viewModel = UNUMColorPickerViewModel(colors: colors, selectedColor: initiallySelectedColor)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }

    private func setupCollectionView() {
        let bundle = Bundle(for: UNUMColorPickerViewController.self)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        colorCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)

        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }

    @IBAction func saveAction(_ sender: Any) {
        delegate?.save()
    }

    @IBAction func cancelAction(_ sender: Any) {
        delegate?.cancel()
    }
}

//MARK: UICollectionViewDataSource
extension UNUMColorPickerViewController: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ColorEditorCollectionViewCell
        let color = viewModel.colors[indexPath.row]
        cell.setupColorButton(colorValue: color, selected: viewModel.selectedColor == color)
        return cell
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.colors.count
    }
}

//MARK: UICollectionViewDelegate
extension UNUMColorPickerViewController: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSet(color: viewModel.colors[indexPath.row])
        viewModel.selectedColor = viewModel.colors[indexPath.row]
        collectionView.reloadData()
    }
}
