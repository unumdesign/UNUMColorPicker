//
//  UNUMColorPickerViewController.swift
//  UNUMColorPicker
//
//  Created by Patrick Flanagan on 10/25/18.
//

import UIKit

public protocol UNUMColorPickerDelegate: class {
    func didSet(color: UIColor)
    func save(_ colorPickerViewController: UNUMColorPickerViewController)
    func cancel(_ colorPickerViewController: UNUMColorPickerViewController, initialColor: UIColor)
}

public class UNUMColorPickerViewController: UIViewController {

    @IBOutlet var colorCollectionView: UICollectionView!

    @IBOutlet public var saveButton: UIButton!
    @IBOutlet public var cancelButton: UIButton!
    @IBOutlet public var titleLabel: UILabel!

    public var delegate: UNUMColorPickerDelegate?

    private var viewModel: UNUMColorPickerViewModel!
    private let cellIdentifier = "ColorEditorCollectionViewCell"

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // It could be argued that having the bundle and the nibName being done from inside the viewController links the view and the viewController too closely. It makes it harder to reuse the viewController with a different view. However, views and viewController are often created in tandem and are often treated as conjoined. (I don't think I've ever encountered viewControllers used with multiple-and-different views, although totally possible. If this were desired, I would be nervous to do that via storyboards in the first place but would rather do so programatically since there is a high chance of breaking something via the storyboard approach which would be hard to find via the debugger.)
    // Furthermore, architectures themselves tend to treat the view and the viewController practically as one. MVVM, for example, has the Model, View, and ViewModel. The `view` is both the view and the viewController -- though the viewController has as much logic as possible in the viewModel and only contains what is necessary to interact with the view.
    // Because of this, I think it is fine to include the bundle and nibName within the init itself. The init can then focus on what needs to be injected.
    // In this case, there are only two things that need to be injected. This is a simple example and so those two things are simply in the initializer. Oftentimes a data-struct is created that contains all the necessary properties. This way, the initializer only ever takes one parameter, called something like `UNUMColorPickerViewControllerProperties`.
    // It could also be argued that the viewController shouldn't be making its own viewModel. Again, this is a simple example and so I opted not to over-complicate this since the complication isn't really needed in this case.
    // If we wanted a more robust architecture (which would make more sense in the full app rather than this small library), then we could have a builder that takes the `UNUMColorPickerProperties` and creates a viewModel with them. The viewModel would then be the parameter for the viewController, and the builder would return the viewController.
    // Also as this is a library, I think it best to keep things simple and agnostic. To use a builder here would force the user to get the viewController by instantiating a builder. But perhaps they don't use builders in their architecture, and so the library would be muddening their architecture. Therefore, especially because this is a library, this simple initializer should suffice.
    /// - Parameters:
    ///   - colors: The colors the user will be able to select.
    ///   - initiallySelectedColor: optional parameter letting a particular color be chosen. Default is to use the first color of colorData or clear if there are no colors in the array.
    public convenience init(colors: [UIColor], initialColor: UIColor) {
        let bundle = Bundle(for: UNUMColorPickerViewController.self)
        self.init(nibName: "UNUMColorPickerViewController", bundle: bundle)
        self.viewModel = UNUMColorPickerViewModel(colors: colors, initialColor: initialColor)
    }

    public func reset(initialColor color: UIColor) {
        self.viewModel.initialColor = color
        colorCollectionView.reloadData()
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
        delegate?.save(self)
    }

    @IBAction func cancelAction(_ sender: Any) {
        delegate?.cancel(self, initialColor: viewModel.initialColor)
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

        // Doing both of these things here could be argued to be architecturally inappropriate. But this is so simple that I decided the complexity that would be added by doing this "correctly" is not worth muddying the waters since this example is so simple. We can cross that bridge when we get there. This is good enough for how simple this library is.
        delegate?.didSet(color: viewModel.colors[indexPath.row])
        viewModel.selectedColor = viewModel.colors[indexPath.row]
        collectionView.reloadData()
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension UNUMColorPickerViewController: UICollectionViewDelegateFlowLayout {
     open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 36)
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 24, bottom: 2, right: 24)
    }
}
