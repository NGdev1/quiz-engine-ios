//
//  MDTextField.swift
//  MD
//
//  Created by Михаил Андреичев on 19/07/2019.
//  Copyright © 2019 MD. All rights reserved.
//

import UIKit

final class MDTextField: UITextField {
    private enum Appearance {
        static let animationDuration: TimeInterval = 0.3
        static let lineViewHeight: CGFloat = 1
    }

    // MARK: - Properties

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.error.color
        label.font = Fonts.SFUIDisplay.regular.font(size: 10)
        label.alpha = 0
        return label
    }()

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = Assets.text.color
        label.textAlignment = .left
        label.center = .zero
        label.font = Fonts.SFUIDisplay.semibold.font(size: 14)
        return label
    }()

    private lazy var lineView = UIView()

    @IBInspectable
    var isFloatingPlaceholder: Bool = false
    var isFloatingErrorLabel: Bool = true
    var automaticallyResetError: Bool = true

    private var isErrorShowing: Bool = false

    @IBInspectable
    override var placeholder: String? {
        set {
            placeholderLabel.text = newValue
            handleTextChanged()
        } get {
            return placeholderLabel.text
        }
    }

    var upperPlaceholderColor: UIColor = Assets.gray.color {
        didSet {
            guard isUpper else { return }
            placeholderLabel.textColor = upperPlaceholderColor
        }
    }

    var placeholderColor: UIColor = Assets.text.color {
        didSet {
            guard !isUpper else { return }
            placeholderLabel.textColor = placeholderColor
        }
    }

    var upperPlaceholderFont: UIFont = Fonts.SFUIDisplay.regular.font(size: 12) {
        didSet {
            guard isUpper else { return }
            placeholderLabel.font = upperPlaceholderFont
        }
    }

    var placeholderFont: UIFont = Fonts.SFUIDisplay.semibold.font(size: 14) {
        didSet {
            guard !isUpper else { return }
            placeholderLabel.font = placeholderFont
        }
    }

    override var text: String? {
        set {
            super.text = newValue
            handleTextChanged()
        } get {
            return super.text
        }
    }

    private var isUpper: Bool = false

    private var isEmpty: Bool = true

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        addActionHandlers()
    }

    private func setupStyle() {
        font = Fonts.SFUIDisplay.semibold.font(size: 14)
        lineView.backgroundColor = Assets.divider.color
    }

    private func addSubviews() {
        addSubview(lineView)
        addSubview(errorLabel)
        addSubview(placeholderLabel)
    }

    private func makeConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.centerX.bottom.width.equalToSuperview()
            make.height.equalTo(Appearance.lineViewHeight)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(3)
            make.leading.trailing.equalTo(lineView)
        }
    }

    // MARK: - Public methods

    func showError(_ text: String?) {
        guard let text = text else { return }
        isErrorShowing = true
        errorLabel.text = text
        lineView.backgroundColor = Assets.error.color
        if isFloatingErrorLabel {
            lineView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-7)
            }
        }
        UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
            self?.errorLabel.alpha = 1
            if self?.isFloatingErrorLabel == true {
                self?.layoutIfNeeded()
            }
        }
    }

    func resetError(animated: Bool = true) {
        isErrorShowing = false
        updateFirstResponderAppearance()
        if isFloatingErrorLabel {
            lineView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
        }
        if animated {
            UIView.animate(withDuration: Appearance.animationDuration) { [weak self] in
                self?.errorLabel.alpha = 0
                if self?.isFloatingErrorLabel == true {
                    self?.layoutIfNeeded()
                }
            }
        } else {
            errorLabel.alpha = 0
            if isFloatingErrorLabel == true {
                layoutIfNeeded()
            }
        }
    }

    // MARK: - Overriden methods

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        if automaticallyResetError {
            resetError()
        } else {
            updateFirstResponderAppearance()
        }
        return true
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        if automaticallyResetError {
            resetError()
        } else {
            updateFirstResponderAppearance()
        }
        return true
    }

    // MARK: - Action handlers

    func addActionHandlers() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if automaticallyResetError {
            resetError()
        }
        handleTextChanged()
    }

    // MARK: - Private methods

    private func updateFirstResponderAppearance() {
        if isErrorShowing {
            lineView.backgroundColor = Assets.error.color
        } else if isFirstResponder {
            lineView.backgroundColor = Assets.baseTint1.color
        } else {
            lineView.backgroundColor = Assets.divider.color
        }
    }

    private func movePlaceholderUpper() {
        placeholderLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
        }
        placeholderLabel.textColor = upperPlaceholderColor // Assets.gray.color
        placeholderLabel.font = upperPlaceholderFont // Fonts.SFUIDisplay.regular.font(size: 12)
        isUpper = true
    }

    private func movePlaceholderToDefaultPosition() {
        placeholderLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
        }
        placeholderLabel.textColor = placeholderColor // Assets.text.color
        placeholderLabel.font = placeholderLabel.font // Fonts.SFUIDisplay.semibold.font(size: 14)
        isUpper = false
    }

    private func textFieldBecameEmpty() {
        if isFloatingPlaceholder {
            movePlaceholderToDefaultPosition()
        } else {
            placeholderLabel.isHidden = false
        }
    }

    private func textFieldBecameFilled() {
        if isFloatingPlaceholder {
            movePlaceholderUpper()
        } else {
            placeholderLabel.isHidden = true
        }
    }

    private func handleTextChanged() {
        if text?.isEmpty == true, isEmpty == false {
            isEmpty = true
            textFieldBecameEmpty()
        } else if text?.isEmpty == false, isEmpty {
            isEmpty = false
            textFieldBecameFilled()
        }
    }
}

extension MDTextField {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        resignFirstResponder()
    }
}
