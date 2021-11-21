//
//  ViewController.swift
//  CheckboxTree-Demo
//
//  Created by mac on 09.11.2021.
//

import UIKit
import CheckboxTree

class Tree: CheckboxTree {
    override init(frame: CGRect) {
        super.init(frame: frame)
        style.isCollapseAnimated = false
        style.isCollapsingAvailable = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    var items = [CheckboxItem(title: "sa",
                              children: [CheckboxItem(title: "vwe wef cwds",
                                                      children: [
                                                       CheckboxItem(title: "cds",
                                                                    isSelected: true),
                                                       CheckboxItem(title: "asdvwwd efw",
                                                                    isSelected: true),
                                                       CheckboxItem(title: "ewtwb btr r",
                                                                    children: [
                                                                       CheckboxItem(title: "ewwx",
                                                                                    isSelected: true)
                                                                    ])
                                                      ],
                                                      groupCollapsed: true),
                                         CheckboxItem(title: "gads",
                                                      subtitle: "uhk uhl ytdy pppi 678",
                                                      isSelected: false),
                                         CheckboxItem(title: "fdsa",
                                                      isSelected: true)]),
                 CheckboxItem(title: "sfaa",
                              isSelected: false),
                 CheckboxItem(title: "geragsddsa",
                              isSelected: true)]

    let tree = Tree()

    override func viewDidLoad() {
        super.viewDidLoad()

        tree.items = items

        view.addSubview(tree)

        tree.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tree.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tree.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tree.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])

        let button = UIButton(type: .system, primaryAction: nil)
        button.backgroundColor = .brown
        button.setTitle("Ass", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: tree.bottomAnchor, constant: 50),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }

    @objc func buttonTapped() {
        items.first?.isSelected.toggle()
        tree.style.isCollapsingAvailable.toggle()
//        tree.style.itemViewStyle.
        tree.reloadTree()
    }
}

