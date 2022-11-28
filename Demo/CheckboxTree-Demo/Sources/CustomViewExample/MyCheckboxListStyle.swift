//
//  MyCheckboxListStyle.swift
//  CheckboxTree-Demo
//
//  Created by mac on 28.11.2022.
//

import APCheckboxTree

class MyCheckboxListStyle: APCheckboxTreeStyle<MyItem> {
    override func getCheckboxItemView() -> APCheckboxItemView<MyItem> {
        return MyCheckboxItemView(style: self)
    }
}
