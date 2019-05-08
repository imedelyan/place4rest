//
//  AddInfoViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var detailsTextView: UITextView!
    @IBOutlet private weak var submitButton: UIButton!

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!
    var placesService: PlacesService!
    var place = Place()

    // MARK: - Variables
    private var hasTextViewJustBegunEditing = true

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        detailsTextView.delegate = self
    }

    // MARK: - IBAction
    @IBAction func didTapSubmitButton(_ sender: Any) {
        guard let text = nameTextField.text else { return }
        place.title = text
        place.content = detailsTextView.text

        // show spinner
        placesService.add(place: place)
            .done {
                // show success message
            }.catch { _ in
                // show error message
                // add to local DB
                // schedule uploading to backend
            }.finally { [weak self] in
                // hide spinner
                self?.navigator.backToRoot()
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddInfoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        submitButton.isEnabled = !text.isEmpty
        submitButton.backgroundColor = text.isEmpty
            ? R.color.light_gray()
            : R.color.green()
    }
}

// MARK: - UITextViewDelegate
extension AddInfoViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if hasTextViewJustBegunEditing {
            textView.text = nil
            textView.textColor = .black
            hasTextViewJustBegunEditing = false
        }
        return true
    }
}
