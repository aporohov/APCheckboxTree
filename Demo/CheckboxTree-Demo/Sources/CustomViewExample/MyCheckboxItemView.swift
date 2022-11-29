//
//  MyCheckboxItemView.swift
//  CheckboxTree-Demo
//
//  Created by mac on 24.11.2022.
//

import UIKit
import APCheckboxTree

class MyCheckboxItemView: APCheckboxItemView<MyItem> {
    override func setupView(item: MyItem, level: Int) {
        let hStackView = UIStackView(arrangedSubviews: [
            emojiView(item: item),
            titleView(item: item),
            selectionImageView(item: item)
        ])
        hStackView.alignment = .center

        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }

    override func titleView(item: MyItem) -> UIView {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 17,
                                            weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.text = item.title

        return titleLabel
    }
    
    override func itemTapped(gestureRecognizer: UITapGestureRecognizer) {
        super.itemTapped(gestureRecognizer: gestureRecognizer)
        
        selectionImageView?.transform = .init(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.selectionImageView?.transform = .identity
        })
    }
    
    func emojiView(item: MyItem) -> UIView {
        let emoji = UILabel()
        emoji.font = .systemFont(ofSize: 32)
        emoji.text = item.emoji
        return emoji
    }
}
