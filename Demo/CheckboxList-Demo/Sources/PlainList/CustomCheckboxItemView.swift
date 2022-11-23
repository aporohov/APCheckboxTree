//
//  CustomCheckboxItemView.swift
//  CheckboxList-Demo
//
//  Created by mac on 24.11.2022.
//

import UIKit
import APCheckboxList

class CustomCheckboxItemView: APCheckboxItemView {
    override func setupView(item: APCheckboxItem, level: Int) {
        let hStackView = UIStackView(arrangedSubviews: [
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
}
