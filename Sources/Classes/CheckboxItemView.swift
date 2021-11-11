//
//  CheckboxItemView.swift
//  CheckboxList
//
//  Created by mac on 09.11.2021.
//

import UIKit

class CheckboxItemView: UIView {

    // MARK: - Constants

    private enum Constants {
//        static var minHeight: CGFloat = 44
//        static var iconSide: CGFloat = 24
//        static var titleLeftOffset: CGFloat = 12
    }

    // MARK: - Properties

    var itemViews: [CheckboxItemView]?

//    private let imageView: UIImageView = {
//        let imageView = UIImageView(frame: CGRect.zero)
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private lazy var subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(gestureRecognizer:)))
        addGestureRecognizer(gestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard let item = item, item.interactionAvailable else {
//            return nil
//        }
//        return super.hitTest(point, with: event)
//    }

    var tapAction: (() -> ())?
    var collapseAction: (() -> ())?

    // MARK: - Action

    @objc func itemTapped(gestureRecognizer: UITapGestureRecognizer) {
        tapAction?()
    }

    @objc func collapseIconTapped(gestureRecognizer: UITapGestureRecognizer) {
        collapseAction?()
    }

    // MARK: - Methods

    func setupView(item: CheckboxItem, leftOffset: CGFloat) {

        for subview in subviews {
            subview.removeFromSuperview()
        }

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftOffset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        if item.type == .group {
            let button = UIButton()
            button.setTitle("ass", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)

            button.addTarget(self, action: #selector(collapseIconTapped(gestureRecognizer:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = item.selectionState.image()

        let imageContainerView = UIView()
        imageContainerView.clipsToBounds = true

        imageContainerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor)
        ])

        let q = imageContainerView.widthAnchor.constraint(equalToConstant: 24)
        let w = imageContainerView.heightAnchor.constraint(equalToConstant: 24)

        q.isActive = true
        w.isActive = true

        q.priority = .defaultLow
        w.priority = .defaultLow

        let a = heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        a.isActive = true
        a.priority = .defaultLow

        stackView.addArrangedSubview(imageContainerView)

        let titleStackView = UIStackView()
        titleStackView.axis = .vertical

        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.text = item.title

        titleStackView.addArrangedSubview(titleLabel)

        if let subtitle = item.subtitle {
            let subtitleLabel = UILabel(frame: CGRect.zero)
            subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            subtitleLabel.textColor = .secondaryLabel
            subtitleLabel.textAlignment = .left
            subtitleLabel.numberOfLines = 0
            subtitleLabel.text = subtitle

            titleStackView.addArrangedSubview(subtitleLabel)
        }

        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(UIView())
    }
}

