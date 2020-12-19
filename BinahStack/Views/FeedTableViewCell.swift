//
//  FeedTableViewCell.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    // MARK: - Constants
    private struct Constants {
        static let huggingPriority: Float = 750.0
    }
    // MARK: - Accessors
    var question: QuestionViewModel! {
        didSet {
            votesNumberLabel.text = question.votesCount
            answersNumberLabel.text = question.answersCount
            titleLabel.text = question.title
            creationLabel.text = question.relativeCreationText
            
            tagsStackView.subviews.forEach({ if let label = $0 as? UILabel { label.removeFromSuperview() }})
            for (index, tag) in question.tags.enumerated() {
                let label = createLabelFor(tag: tag)
                let priority = UILayoutPriority(rawValue: Constants.huggingPriority - Float(index))
                label.setContentCompressionResistancePriority(priority, for: .horizontal)
                tagsStackView.insertArrangedSubview(label, at: tagsStackView.subviews.count-1)
            }
        }
    }
    
    // MARK: - Helpers
    func createLabelFor(tag: String) -> UILabel {
        let label = UILabel()
        label.text = " \(tag) "
        label.backgroundColor = .systemTeal
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 21))
        return label
    }
    
    // MARK: - Outlets
    @IBOutlet weak var votesNumberLabel: UILabel!
    @IBOutlet weak var answersNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    @IBOutlet weak var tagsStackView: UIStackView!
    
}
