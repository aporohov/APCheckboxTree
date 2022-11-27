//
//  CheckboxNode.swift
//  APCheckboxTree
//
//  Created by mac on 21.11.2021.
//

import UIKit

/// Tree node
class CheckboxNode {

    // MARK: - Properties

    var style: APCheckboxTreeStyle

    weak var parentNode: CheckboxNode?

    var item: APCheckboxItem
    var depth: Int

    var itemView: APCheckboxItemView

    var children: [CheckboxNode] = []

    weak var delegate: CheckboxItemDelegate?

    // MARK: - Init

    init(item: APCheckboxItem, depth: Int, parentNode: CheckboxNode?, style: APCheckboxTreeStyle, delegate: CheckboxItemDelegate?) {
        self.item = item
        self.depth = depth
        self.parentNode = parentNode
        self.style = style
        self.delegate = delegate

        let itemViewType = style.checkboxItemViewType
        itemView = itemViewType.init(style: style)
        itemView.setupView(item: item, level: depth)

        setupItemViewActions()

        generateChildNodes()
    }

    // MARK: - Methods

    func updateItemViewVisibility() {
        let isItemViewHidden = isHidden()

        if itemView.isHidden != isItemViewHidden {
            itemView.isHidden = isItemViewHidden
        }
        itemView.alpha = isItemViewHidden ? 0 : 1
    }

    func isHidden() -> Bool {
        if style.isCollapseAvailable == false {
            return false
        }

        if let parentNode = parentNode {
            if parentNode.item.isGroupCollapsed {
                return true
            } else {
                return parentNode.isHidden()
            }
        }
        return false
    }

    func setupItemViewActions() {
        itemView.tapAction = { [weak self] in
            guard let self = self else {
                return
            }

            if self.item.selectionState == .mixed {

                if self.item.children.filter({ item in
                    item.isEnabled
                }).contains(where: { item in
                    item.isSelected == false
                }) {
                    self.item.isSelected = true
                } else {
                    self.item.isSelected = false
                }

            } else {
                self.item.isSelected.toggle()
            }

            self.getRootNode().forEachBranchNode { node in
                node.itemView.updateSelectionImage(item: node.item)
            }

            self.delegate?.checkboxItemDidSelected(item: self.item)
        }

        itemView.collapseAction = { [weak self] in
            guard let self = self else {
                return
            }

            self.item.isGroupCollapsed.toggle()

            let collapseBlock = {
                self.itemView.transformGroupArrow(isCollapsed: self.item.isGroupCollapsed)

                self.forEachChildNode { node in
                    node.updateItemViewVisibility()
                }
            }

            if self.style.isCollapseAnimated {
                UIView.animate(withDuration: self.style.collapseAnimationDuration) {
                    collapseBlock()
                }
            } else {
                collapseBlock()
            }
        }
    }

    func generateChildNodes() {
        for item in item.children {
            let node = CheckboxNode(item: item,
                                    depth: depth + 1,
                                    parentNode: self,
                                    style: style,
                                    delegate: delegate)
            children.append(node)
        }
    }

    func getRootNode() -> CheckboxNode {
        if let parentNode = parentNode {
            return parentNode.getRootNode()
        }
        return self
    }

    func forEachBranchNode(_ closure: (CheckboxNode) -> ()) {
        closure(self)
        forEachChildNode(closure)
    }

    func forEachChildNode(_ closure: (CheckboxNode) -> ()) {
        children.forEach { childNode in
            closure(childNode)
            childNode.forEachChildNode(closure)
        }
    }
}
