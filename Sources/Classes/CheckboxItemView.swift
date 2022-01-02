//
//  CheckboxItemView.swift
//  CheckboxTree
//
//  Created by mac on 09.11.2021.
//

import UIKit

/// Resulting checkbox tree is a stackView filled with this views
class CheckboxItemView: UIView {

    // MARK: - Properties

    var style: CheckboxTreeStyle

    weak var groupArrowButton: UIButton?
    weak var selectionImageView: UIImageView?

    var tapAction: (() -> ())?
    var collapseAction: (() -> ())?

    // MARK: - Init

    init(style: CheckboxTreeStyle) {
        self.style = style
        super.init(frame: .zero)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(gestureRecognizer:)))
        addGestureRecognizer(gestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc func itemTapped(gestureRecognizer: UITapGestureRecognizer) {
        tapAction?()
    }

    @objc func collapseIconTapped(gestureRecognizer: UITapGestureRecognizer) {
        collapseAction?()
    }

    // MARK: - Methods

    func transformGroupArrow(isCollapsed: Bool) {
        groupArrowButton?.transform = isCollapsed ? .identity : .identity.rotated(by: .pi/2)
    }

    func updateSelectionImage(item: CheckboxItem) {
        switch item.selectionState {
        case .on:
            selectionImageView?.image = style.images.checkboxOn
        case .off:
            selectionImageView?.image = style.images.checkboxOff
        case .mixed:
            selectionImageView?.image = style.images.checkboxMixed
        }

        if !item.isEnabled {
            selectionImageView?.image = selectionImageView?.image?.withRenderingMode(.alwaysTemplate)
            selectionImageView?.tintColor = style.itemViewStyle.disabledStateColor
        }
    }

    func setupView(item: CheckboxItem, level: Int) {

        for subview in subviews {
            subview.removeFromSuperview()
        }

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = style.itemViewStyle.elementsSpacing

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        for _ in 0..<level {
            arrangeLevelEmptyView(in: stackView)
        }

        addGroupArrowView(in: stackView, item: item)
        addSelectionImageView(in: stackView, item: item)
        addTitleView(in: stackView, item: item)

        stackView.addArrangedSubview(UIView())

        heightAnchor.constraint(greaterThanOrEqualToConstant: style.itemViewStyle.minHeight).isActive = true
    }

    // MARK: - Arranged views

    func arrangeLevelEmptyView(in stackView: UIStackView) {
        let emptyView = UIView()
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
            emptyView.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
        ])
        stackView.addArrangedSubview(emptyView)
    }

    func addGroupArrowView(in stackView: UIStackView, item: CheckboxItem) {

        if style.isCollapsingAvailable == false {
            return
        }

        if item.type == .group {
            let button = UIButton()
            button.setBackgroundImage(style.images.groupArrow, for: .normal)
            button.addTarget(self, action: #selector(collapseIconTapped(gestureRecognizer:)), for: .touchUpInside)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
                button.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
            ])

            stackView.addArrangedSubview(button)
            groupArrowButton = button

            transformGroupArrow(isCollapsed: item.isGroupCollapsed)
        } else {
            arrangeLevelEmptyView(in: stackView)
        }
    }

    func addSelectionImageView(in stackView: UIStackView, item: CheckboxItem) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
            imageView.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
        ])

        stackView.addArrangedSubview(imageView)

        selectionImageView = imageView
        updateSelectionImage(item: item)
    }

    func addTitleView(in stackView: UIStackView, item: CheckboxItem) {
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical

        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = style.itemViewStyle.titleFont
        titleLabel.textColor = item.isEnabled ? style.itemViewStyle.titleColor : style.itemViewStyle.disabledStateColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.text = item.title

        titleStackView.addArrangedSubview(titleLabel)

        if let subtitle = item.subtitle {
            let subtitleLabel = UILabel(frame: CGRect.zero)
            subtitleLabel.font = style.itemViewStyle.subtitleFont
            subtitleLabel.textColor = item.isEnabled ? style.itemViewStyle.subtitleColor : style.itemViewStyle.disabledStateColor
            subtitleLabel.textAlignment = .left
            subtitleLabel.numberOfLines = 0
            subtitleLabel.text = subtitle

            titleStackView.addArrangedSubview(subtitleLabel)
        }

        stackView.addArrangedSubview(titleStackView)
    }
}

