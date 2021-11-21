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

    let groupArrowButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(CheckboxImageProvider.groupArrow(), for: .normal)
        button.addTarget(self, action: #selector(collapseIconTapped(gestureRecognizer:)), for: .touchUpInside)
        return button
    }()

    let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var tapAction: (() -> ())?
    var collapseAction: (() -> ())?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(gestureRecognizer:)))
        addGestureRecognizer(gestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Action

    @objc func itemTapped(gestureRecognizer: UITapGestureRecognizer) {
        tapAction?()
    }

    @objc func collapseIconTapped(gestureRecognizer: UITapGestureRecognizer) {
        collapseAction?()
    }

    // MARK: - Methods

    func transformGroupArrow(isCollapsed: Bool) {
        groupArrowButton.transform = isCollapsed ? .identity : .identity.rotated(by: .pi/2)
    }

    func setupView(item: CheckboxItem, level: Int) {

        for subview in subviews {
            subview.removeFromSuperview()
        }

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        for _ in 0..<level {
            arrangeEmptyView(in: stackView)
        }

        if item.type == .group {
            stackView.addArrangedSubview(groupArrowButton)
            transformGroupArrow(isCollapsed: item.isGroupCollapsed)
        } else {
            arrangeEmptyView(in: stackView)
        }

        selectionImageView.image = item.selectionState.image()
        stackView.addArrangedSubview(selectionImageView)

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

        heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }

    func arrangeEmptyView(in stackView: UIStackView) {
        let emptyView = UIView()
        NSLayoutConstraint.activate([
            emptyView.heightAnchor.constraint(equalToConstant: 24),
            emptyView.widthAnchor.constraint(equalToConstant: 24)
        ])
        stackView.addArrangedSubview(emptyView)
    }
}

