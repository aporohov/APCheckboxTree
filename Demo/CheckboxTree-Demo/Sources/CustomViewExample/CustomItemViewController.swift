//
//  CustomItemViewController.swift
//  CheckboxTree-Demo
//
//  Created by mac on 20.11.2022.
//

import UIKit
import APCheckboxTree

class CustomItemViewController: UIViewController {
    
    let items = [MyItem(emoji: "🍇", title: "Grapes"),
                 MyItem(emoji: "🍉", title: "Watermelon"),
                 MyItem(emoji: "🍎", title: "Apple"),
                 MyItem(emoji: "🍌", title: "Banana"),
                 MyItem(emoji: "🥒", title: "Cucumber")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create checkbox list with custom style
        let checkboxList = APCheckboxTree(style: MyCheckboxListStyle())
        
        // Assign custom checkbox images
        checkboxList.style.images.checkboxOn = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        checkboxList.style.images.checkboxOff = UIImage(systemName: "heart")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        checkboxList.items = items
        
        checkboxList.delegate = self
        
        view.addSubview(checkboxList)
        checkboxList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            checkboxList.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            checkboxList.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension CustomItemViewController: APCheckboxTreeDelegate {
    func checkboxItemDidSelected(item: APCheckboxItem) {
        if let item = item as? MyItem {
            if item.isSelected {
                print("i like \(item.emoji)")
            } else {
                print("i don't like \(item.emoji)")
            }
        }
    }
}
