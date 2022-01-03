//
//  ViewController.swift
//  CheckboxTree-Demo
//
//  Created by mac on 09.11.2021.
//

import UIKit
import CheckboxTree

class ViewController: UIViewController {

    var items = [CheckboxItem(title: "Europe",
                              subtitle: "European cities",
                              children: [CheckboxItem(title: "Berlin",
                                                      isSelected: false),
                                         CheckboxItem(title: "Saint Petersburg",
                                                      isSelected: false),

                                         CheckboxItem(title: "UK",
                                                      subtitle: "Cities in United Kingdom",
                                                      children: [
                                                        CheckboxItem(title: "London",
                                                                     isSelected: true),
                                                        CheckboxItem(title: "Scotland",
                                                                     subtitle: "Cities in Scotland",
                                                                     children: [
                                                                        CheckboxItem(title: "Edinburgh",
                                                                                     isSelected: true)
                                                                     ])
                                                      ],
                                                      groupCollapsed: true)]),
                 CheckboxItem(title: "New York",
                              isSelected: false),
                 CheckboxItem(title: "Beijing",
                              isSelected: true)]

    let tree = CheckboxTree()

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
        contentStackView.spacing = 20
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
        addIsEnabledButtons(in: contentStackView)
        addCollapseAnimationButton(in: contentStackView)
        addCollapseEnabledButton(in: contentStackView)

        tree.delegate = self
        tree.items = items

        contentStackView.addArrangedSubview(tree)
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
        tree.style.itemViewStyle.minHeight = CGFloat(sender.value)
        tree.reloadTree()
    }

    func addSpacingSlider(in stackView: UIStackView) {
        let label = UILabel()
        label.text = "Item spacing"

        let slider = UISlider()
        slider.minimumValue = 5
        slider.maximumValue = 12
        slider.value = 8

        let contentStackView = UIStackView(arrangedSubviews: [label, slider])
        contentStackView.spacing = 10
        contentStackView.distribution = .fillEqually

        stackView.addArrangedSubview(contentStackView)

        slider.addTarget(self, action: #selector(spacingChanged(sender:)), for: .valueChanged)
    }

    @objc func spacingChanged(sender: UISlider) {
        tree.style.itemViewStyle.elementsSpacing = CGFloat(sender.value)
        tree.reloadTree()
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
        tree.style.itemViewStyle.levelBoxSize = .init(width: side, height: side)
        tree.reloadTree()
    }

    func addIsEnabledButtons(in stackView: UIStackView) {
        let berlinButton = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let berlinItem = self?.items.first?.children[0]

            berlinItem?.isEnabled.toggle()
            self?.tree.reloadTree()

            var buttonTitle = "Berlin isEnabled"
            if let isOn = berlinItem?.isEnabled {
                buttonTitle += isOn ? " = true" : " = false"
            }

            (act.sender as? UIButton)?.setTitle(buttonTitle, for: .normal)
        }))
        berlinButton.setTitle("Berlin isEnabled = true", for: .normal)

        let ukButton = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let ukItem = self?.items.first?.children[2]

            ukItem?.isEnabled.toggle()
            self?.tree.reloadTree()

            var buttonTitle = "UK isEnabled"
            if let isOn = ukItem?.isEnabled {
                buttonTitle += isOn ? " = true" : " = false"
            }

            (act.sender as? UIButton)?.setTitle(buttonTitle, for: .normal)
        }))
        ukButton.setTitle("UK isEnabled = true", for: .normal)

        stackView.addArrangedSubview(berlinButton)
        stackView.addArrangedSubview(ukButton)
    }

    func addCollapseAnimationButton(in stackView: UIStackView) {
        let button = UIButton(configuration: .borderedProminent(), primaryAction: .init(handler: { [weak self] act in
            let style = self?.tree.style
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
            let style = self?.tree.style

            style?.isCollapseAvailable.toggle()
            self?.tree.reloadTree()

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

extension ViewController: CheckboxTreeDelegate {
    func checkboxTreeItemHasBeenTapped(item: CheckboxItem) {
        print(item)
    }
}
