//
//  CheckboxItemDelegate.swift
//  CheckboxTree
//
//  Created by mac on 03.01.2022.
//

import Foundation

protocol CheckboxItemDelegate: NSObject {
    func checkboxItemHasBeenTapped(item: CheckboxItem)
}
