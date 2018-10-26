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

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionView()
    }

    @IBOutlet var colorCollectionView: UICollectionView!
    //collection view data dource
    private var colors: [UIColor]!
    private let cellIdentifier = "ColorEditorCollectionViewCell"

    //delegate: communicate with outside
    public var delegate: UNUMColorPickerDelegate?

    fileprivate var selectedColor: UIColor!

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public convenience init(colors: [UIColor], initiallySelectedColor: UIColor? = nil) {
        let bundle = Bundle(for: UNUMColorPickerViewController.self)
        self.init(nibName: "UNUMColorPickerViewController", bundle: bundle)
        self.colors = colors
        selectedColor = initiallySelectedColor ?? colors.first ?? .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        let color = colors[indexPath.row]
        cell.setupColorButton(colorValue: color, selected: selectedColor == color)
        return cell
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
}

//MARK: UICollectionViewDelegate
extension UNUMColorPickerViewController: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSet(color: colors[indexPath.row])
        selectedColor = colors[indexPath.row]
        collectionView.reloadData()
    }
}
