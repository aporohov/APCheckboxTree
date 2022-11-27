//
//  TreeViewController.swift
//  CheckboxTree-Demo
//
//  Created by mac on 20.11.2022.
//

import UIKit
import APCheckboxTree

class TreeViewController: UIViewController {

    var items = [APCheckboxItem(title: "Europe",
                                children: [
                                    APCheckboxItem(title: "Alps",
                                                   children: [
                                                    APCheckboxItem(title: "Mont Blanc",
                                                                   subtitle: "France/Italy, 4810m",
                                                                   isSelected: false),
                                                    APCheckboxItem(title: "Matterhorn",
                                                                   subtitle: "Switzerland, 4478m",
                                                                   isSelected: false),
                                                   ]),
                                    APCheckboxItem(title: "Elbrus",
                                                   subtitle: "Russia, 5642m",
                                                   isSelected: false),
                                    APCheckboxItem(title: "Etna",
                                                   subtitle: "Italy, 3350m",
                                                   isSelected: false)
                                ],
                        isGroupCollapsed: true),
                 APCheckboxItem(title: "Asia",
                                children: [
                                    APCheckboxItem(title: "Himalayas",
                                                   children: [
                                                    APCheckboxItem(title: "Everest",
                                                                   subtitle: "Nepal/China, 8848m",
                                                                   isSelected: false),
                                                    APCheckboxItem(title: "Lhotse",
                                                                   subtitle: "Nepal/China, 8516m",
                                                                   isSelected: false),
                                                    APCheckboxItem(title: "Annapurna",
                                                                   subtitle: "Nepal, 8091m",
                                                                   isSelected: false)
                                                   ],
                                           isGroupCollapsed: true),
                                    APCheckboxItem(title: "K2",
                                                   subtitle: "Pakistan/China, 8614m",
                                                   isSelected: true)]),
                 APCheckboxItem(title: "North America",
                                children: [
                                    APCheckboxItem(title: "Denali",
                                                   subtitle: "USA, 6190m",
                                                   isSelected: true)
                                ])
                 
    ]

    let checkboxTree = APCheckboxTree()

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let contentStackView = UIStackView()
        contentStackView.spacing = 10
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 0)
        ])

        addHeightSlider(in: contentStackView)
        addSpacingSlider(in: contentStackView)
        addLevelBoxSlider(in: contentStackView)
        addIsEnabledButton(in: contentStackView)
        addCollapseAnimationButton(in: contentStackView)
        addCollapseEnabledButton(in: contentStackView)

        // Setup checkbox list
        
        checkboxTree.delegate = self
        checkboxTree.items = items

        contentStackView.addArrangedSubview(checkboxTree)
    }

    func addHeightSlider(in stackView: UIStackView) {
        let label = UILabel()
        label.text = "Item height"

        let slider = UISlider()
        slider.minimumValue = 30
        slider.maximumValue = 60
        slider.value = 44

        let contentStackView = UIStackView(arrangedSubviews: [label, slider])
        contentStackView.spacing = 10
        contentStackView.distribution = .fillEqually

        stackView.addArrangedSubview(contentStackView)

        slider.addTarget(self, action: #selector(heightChanged(sender:)), for: .valueChanged)
    }

    @objc func heightChanged(sender: UISlider) {
        checkboxTree.style.itemViewStyle.minHeight = CGFloat(sender.value)
        checkboxTree.reload()
    }

    func addSpacingSlider(in stackView: UIStackView) {
        let label = UILabel()
        label.text = "Item spacing"

        let slider = UISlider()
        slider.minimumValue = 4
        slider.maximumValue = 12
        slider.value = 8

        let contentStackView = UIStackView(arrangedSubviews: [label, slider])
        contentStackView.spacing = 10
        contentStackView.distribution = .fillEqually

        stackView.addArrangedSubview(contentStackView)

        slider.addTarget(self, action: #selector(spacingChanged(sender:)), for: .valueChanged)
    }

    @objc func spacingChanged(sender: UISlider) {
        checkboxTree.style.itemViewStyle.elementsSpacing = CGFloat(sender.value)
        checkboxTree.reload()
    }

    func addLevelBoxSlider(in stackView: UIStackView) {
        let label = UILabel()
        label.text = "Level box size"

        let slider = UISlider()
        slider.minimumValue = 16
        slider.maximumValue = 30
        slider.value = 24

        let contentStackView = UIStackView(arrangedSubviews: [label, slider])
        contentStackView.spacing = 10
        contentStackView.distribution = .fillEqually

        stackView.addArrangedSubview(contentStackView)

        slider.addTarget(self, action: #selector(levelBoxChanged(sender:)), for: .valueChanged)
    }

    @objc func levelBoxChanged(sender: UISlider) {
        let side = CGFloat(sender.value)
        checkboxTree.style.itemViewStyle.levelBoxSize = .init(width: side, height: side)
        checkboxTree.reload()
    }

    func addIsEnabledButton(in stackView: UIStackView) {
        let button = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let himalayasItem = self?.items[1].children[0]

            himalayasItem?.isEnabled.toggle()
            self?.checkboxTree.reload()

            var buttonTitle = "Item isEnabled"
            if let isOn = himalayasItem?.isEnabled {
                buttonTitle += isOn ? " = true" : " = false"
            }

            (act.sender as? UIButton)?.setTitle(buttonTitle, for: .normal)
        }))
        button.setTitle("Item isEnabled = true", for: .normal)

        stackView.addArrangedSubview(button)
    }

    func addCollapseAnimationButton(in stackView: UIStackView) {
        let button = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let style = self?.checkboxTree.style
            style?.isCollapseAnimated.toggle()

            var buttonTitle = "isCollapseAnimated"
            if let isOn = style?.isCollapseAnimated {
                buttonTitle += isOn ? " = true" : " = false"
            }

            (act.sender as? UIButton)?.setTitle(buttonTitle, for: .normal)
        }))
        button.setTitle("isCollapseAnimated = true", for: .normal)

        stackView.addArrangedSubview(button)
    }

    func addCollapseEnabledButton(in stackView: UIStackView) {
        let button = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let style = self?.checkboxTree.style

            style?.isCollapseAvailable.toggle()
            self?.checkboxTree.reload()

            var buttonTitle = "isCollapseAvailable"
            if let isOn = style?.isCollapseAvailable {
                buttonTitle += isOn ? " = true" : " = false"
            }

            (act.sender as? UIButton)?.setTitle(buttonTitle, for: .normal)
        }))
        button.setTitle("isCollapseAvailable = true", for: .normal)

        stackView.addArrangedSubview(button)
    }
}

extension TreeViewController: APCheckboxTreeDelegate {
    func checkboxItemDidSelected(item: APCheckboxItem) {
        print(item)
    }
}

