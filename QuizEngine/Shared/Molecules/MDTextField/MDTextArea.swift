//
//  MDTextArea.swift
//  MD
//
//  Created by Михаил Андреичев on 06/10/2019.
//  Copyright © 2019 MD. All rights reserved.
//

import SnapKit

protocol MDTextAreaDelegate: AnyObject {
    func textDidChange(textArea: MDTextArea, text: String)
}

final class MDTextArea: UIView {
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
        label.textColor = Assets.gray.color
        label.textAlignment = .left
        label.center = .zero
        label.font = Fonts.SFUIDisplay.regular.font(size: 18)
        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = Fonts.SFUIDisplay.regular.font(size: 18)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()

    private lazy var lineView = UIView()

    weak var delegate: MDTextAreaDelegate?

    var isFloatingPlaceholder: Bool = true

    var isScrollEnabled: Bool {
        get {
            return textView.isScrollEnabled
        }
        set {
            textView.isScrollEnabled = newValue
        }
    }

    var placeholder: String {
        get {
            return placeholderLabel.text ?? .empty
        }
        set {
            placeholderLabel.text = newValue
            handleTextChanged()
        }
    }

    var customInputAccessoryView: UIView? {
        get {
            return textView.inputAccessoryView
        }
        set {
            textView.inputAccessoryView = newValue
        }
    }

    var text: String? {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
            handleTextChanged()
        }
    }

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
    }

    private func setupStyle() {
        lineView.backgroundColor = Assets.divider.color
    }

    private func addSubviews() {
        addSubview(textView)
        addSubview(placeholderLabel)
        addSubview(lineView)
        addSubview(errorLabel)
    }

    private func makeConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(textView).inset(8)
        }
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.centerX.bottom.width.equalToSuperview()
            make.height.equalTo(Appearance.lineViewHeight)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(4)
            make.leading.trailing.equalTo(lineView)
        }
    }

    // MARK: - Internal methods

    func showError(_ text: String) {
        errorLabel.text = text
        errorLabel.fadeIn(duration: Appearance.animationDuration)
        lineView.backgroundColor = Assets.error.color
    }

    func resetError() {
        errorLabel.fadeOut(duration: Appearance.animationDuration)
        if textView.isFirstResponder {
            lineView.backgroundColor = Assets.baseTint1.color
        } else {
            lineView.backgroundColor = Assets.divider.color
        }
    }

    // MARK: - Private methods

    private func movePlaceholderUpper() {
        placeholderLabel.snp.updateConstraints { make in
            make.top.equalTo(textView).inset(-10)
        }
        placeholderLabel.textColor = Assets.gray.color
        placeholderLabel.font = Fonts.SFUIDisplay.regular.font(size: 12)
    }

    private func movePlaceholderToDefaultPosition() {
        placeholderLabel.snp.updateConstraints { make in
            make.top.equalTo(textView).inset(8)
        }
        placeholderLabel.textColor = Assets.gray.color
        placeholderLabel.font = Fonts.SFUIDisplay.regular.font(size: 18)
    }

    private func textAreaBecameEmpty() {
        if isFloatingPlaceholder {
            movePlaceholderToDefaultPosition()
        } else {
            placeholderLabel.isHidden = false
        }
    }

    private func textAreaBecameFilled() {
        if isFloatingPlaceholder {
            movePlaceholderUpper()
        } else {
            placeholderLabel.isHidden = true
        }
    }

    private func handleTextChanged() {
        if textView.text.isEmpty, isEmpty == false {
            isEmpty = true
            textAreaBecameEmpty()
        } else if textView.text.isEmpty == false, isEmpty {
            isEmpty = false
            textAreaBecameFilled()
        }
    }

    // MARK: - Overriden methods

    override func becomeFirstResponder() -> Bool {
        return textView.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }
}

// MARK: - UITextViewDelegate

extension MDTextArea: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textDidChange(textArea: self, text: textView.text)
        handleTextChanged()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        resetError()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        resetError()
    }
}
