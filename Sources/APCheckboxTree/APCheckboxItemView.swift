//
//  APCheckboxItemView.swift
//  APCheckboxTree
//
//  Created by mac on 09.11.2021.
//

import UIKit

/// Item view.
/// Final checkbox tree is a stackView filled with this kind of views.
open class APCheckboxItemView<T: APCheckboxItem>: UIView {

    // MARK: - Properties

    public private(set) var style: APCheckboxTreeStyle<T>

    public private(set) var groupArrowButton: UIButton?
    public private(set) var selectionImageView: UIImageView?

    public internal(set) var tapAction: (() -> ())?
    public internal(set) var collapseAction: (() -> ())?

    // MARK: - Init

    public required init(style: APCheckboxTreeStyle<T>) {
        self.style = style
        super.init(frame: .zero)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(gestureRecognizer:)))
        addGestureRecognizer(gestureRecognizer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc open func itemTapped(gestureRecognizer: UITapGestureRecognizer) {
        tapAction?()
    }

    @objc open func collapseIconTapped(gestureRecognizer: UITapGestureRecognizer) {
        collapseAction?()
    }

    // MARK: - Methods

    open func transformGroupArrow(isCollapsed: Bool) {
        groupArrowButton?.transform = isCollapsed ? .identity : .identity.rotated(by: .pi/2)
    }

    open func updateSelectionImage(item: APCheckboxItem) {
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
    
    // MARK: - Setup View
    
    open func setupView(item: T, level: Int) {
        let stackView = UIStackView()
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

        heightAnchor.constraint(greaterThanOrEqualToConstant: style.itemViewStyle.minHeight).isActive = true

        for _ in 0..<level {
            stackView.addArrangedSubview(levelBoxView())
        }

        if style.isCollapseAvailable {
            stackView.addArrangedSubview(groupArrowView(item: item))
        }
        
        stackView.addArrangedSubview(selectionImageView(item: item))
        stackView.addArrangedSubview(titleView(item: item))
    }

    // MARK: - Setup subviews

    open func levelBoxView() -> UIView {
        let emptyView = UIView()
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
            emptyView.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
        ])
        return emptyView
    }

    open func groupArrowView(item: T) -> UIView {
        if item.type == .group {
            let button = UIButton()
            button.setBackgroundImage(style.images.groupArrow, for: .normal)
            button.addTarget(self, action: #selector(collapseIconTapped(gestureRecognizer:)), for: .touchUpInside)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
                button.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
            ])

            groupArrowButton = button
            transformGroupArrow(isCollapsed: item.isGroupCollapsed)
            
            return button
        } else {
            return levelBoxView()
        }
    }

    open func selectionImageView(item: T) -> UIView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.width),
            imageView.heightAnchor.constraint(equalToConstant: style.itemViewStyle.levelBoxSize.height)
        ])

        selectionImageView = imageView
        updateSelectionImage(item: item)
        
        return imageView
    }

    open func titleView(item: T) -> UIView {
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

        return titleStackView
    }
}

