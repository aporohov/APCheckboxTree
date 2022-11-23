//
//  PlainListViewController.swift
//  CheckboxList-Demo
//
//  Created by mac on 20.11.2022.
//

import UIKit
import APCheckboxList

class PlainListViewController: UIViewController {
    
    let items = [APCheckboxItem(title: "Orange"),
                 APCheckboxItem(title: "Watermelon"),
                 APCheckboxItem(title: "Apple", isSelected: true),
                 APCheckboxItem(title: "Banana"),
                 APCheckboxItem(title: "Cucumber")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkboxList = APCheckboxList()
        
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
