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

    @IBOutlet var colorCollectionView: UICollectionView!
    //collection view data dource
    private var colors: [UIColor]!
    private let cellIdentifier = "ColorEditorCollectionViewCell"

    //delegate: communicate with outside
    public var colorPickerDelegaet: UNUMColorPickerDelegate?

    fileprivate var initColor: UIColor!
    fileprivate var selectedColor: UIColor!

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public convenience init() {
        let bundle = Bundle(for: UNUMColorPickerViewController.self)
        self.init(nibName: "UNUMColorPickerViewController", bundle: bundle)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //need to find a way to init view with colors and init color
    public func setup(colors: [UIColor], initColor: UIColor?) {
        self.colors = colors
        // set init color, if nil use the first color from array
        self.initColor = initColor == nil ? colors.first : initColor
        selectedColor = self.initColor
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
        colorPickerDelegaet?.save()
    }

    @IBAction func cancelAction(_ sender: Any) {
        colorPickerDelegaet?.cancel()
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
        colorPickerDelegaet?.didSet(color: colors[indexPath.row])
        selectedColor = colors[indexPath.row]
        collectionView.reloadData()
    }
}
