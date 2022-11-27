//
//  PlainListViewController.swift
//  CheckboxTree-Demo
//
//  Created by mac on 20.11.2022.
//

import UIKit
import APCheckboxTree

class MyItem: APCheckboxItem {
    public var a: Bool = true
    
    override init(title: String, subtitle: String? = nil, isSelected: Bool, children: [APCheckboxItem], isGroupCollapsed: Bool) {
        super.init(title: title, subtitle: subtitle, isSelected: isSelected, children: children, isGroupCollapsed: isGroupCollapsed)
    }
}

class PlainListViewController: UIViewController {
    
    let items = [MyItem(title: "Orange"),
                 MyItem(title: "Watermelon"),
                 MyItem(title: "Apple"),
                 MyItem(title: "Banana"),
                 MyItem(title: "Cucumber")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkboxList = APCheckboxTree()
        
        checkboxList.style.checkboxItemViewType = CustomCheckboxItemView.self
        
        checkboxList.items = items
        
        view.addSubview(checkboxList)
        checkboxList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            checkboxList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            checkboxList.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
