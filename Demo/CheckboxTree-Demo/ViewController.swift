//
//  ViewController.swift
//  CheckboxList-Demo
//
//  Created by mac on 09.11.2021.
//

import UIKit
import CheckboxTree

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let list = CheckboxTree()
        list.items = [CheckboxItem(title: "sa",
                                   children: [CheckboxItem(title: "vwe wef cwds",
                                                           children: [
                                                            CheckboxItem(title: "cds",
                                                                         isSelected: true),
                                                            CheckboxItem(title: "asdvwwd efw",
                                                                         isSelected: true)
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

        view.addSubview(list)

        list.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            list.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            list.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }


}
