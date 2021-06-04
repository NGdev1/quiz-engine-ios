//
//  OptionRadioCell.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import UIKit

final class OptionRadioCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var radioImageView: UIImageView!
    @IBOutlet var optionTextLabel: UILabel!

    // MARK: - Internal methods

    func configure(option: QuestionOption, isSelected: Bool) {
        optionTextLabel.text = option.text
        radioImageView.image = isSelected ? Assets.radiobuttonOn.image : Assets.radiobuttonOff.image
    }
}
