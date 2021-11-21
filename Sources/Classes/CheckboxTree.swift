//
//  CheckboxTree.swift
//  CheckboxTree
//
//  Created by mac on 09.11.2021.
//

import UIKit

//struct CheckboxList

public class CheckboxTree: UIView {

    // MARK: - Public properties

    /// Элементы списка
    public var items: [CheckboxItem] = [] {
        didSet {
            setupStackView()
        }
    }


    // MARK: - Private properties

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var nodes: [CheckboxNode] = []

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    func setupView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupStackView() {
        stackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }

        nodes.removeAll()

        arrangeItems()
    }

    func arrangeItems() {
        for item in items {
            let node = CheckboxNode(item: item, depth: 0, parentNode: nil)
            nodes.append(node)

            node.forEachBranchNode { childNode in
                stackView.addArrangedSubview(childNode.itemView)

                childNode.updateItemViewVisibility()
            }
        }
    }
}


open class CheckboxNode {

    weak var parentNode: CheckboxNode?

    var item: CheckboxItem
    var depth: Int

    var itemView: CheckboxItemView

    var children: [CheckboxNode] = []

    init(item: CheckboxItem, depth: Int, parentNode: CheckboxNode?) {
        self.item = item
        self.depth = depth
        self.parentNode = parentNode

        itemView = CheckboxItemView()
        setupItemViewActions()
        updateItemView()

        generateChildNodes()
    }

    private func updateItemView() {
        itemView.setupView(item: item, level: depth)
    }

    func updateItemViewVisibility() {
        let isItemViewHidden = isHidden()

        if itemView.isHidden != isItemViewHidden {
            itemView.isHidden = isItemViewHidden
        }
        itemView.alpha = isItemViewHidden ? 0 : 1
    }

    private func isHidden() -> Bool {
        if let parentNode = parentNode {
            if parentNode.item.isGroupCollapsed {
                return true
            } else {
                return parentNode.isHidden()
            }
        }
        return false
    }

    private func setupItemViewActions() {
        itemView.tapAction = { [weak self] in
            guard let self = self else {
                return
            }

            self.item.isSelected.toggle()

            self.getRootNode().forEachBranchNode { node in
                node.updateItemView()
            }
        }

        itemView.collapseAction = { [weak self] in
            guard let self = self else {
                return
            }

            self.item.isGroupCollapsed.toggle()

            UIView.animate(withDuration: 0.2, delay: 0, options: []) {

                self.itemView.transformGroupArrow(isCollapsed: self.item.isGroupCollapsed)

                self.forEachChildNode { node in
                    node.updateItemViewVisibility()
                }
            }
        }
    }

    private func generateChildNodes() {
        for item in item.children {
            let node = CheckboxNode(item: item, depth: depth + 1, parentNode: self)
            children.append(node)
        }
    }

//    func getAllBranchViews() -> [CheckboxItemView] {
//        var views: [CheckboxItemView] = [itemView]
//
//        views.append(contentsOf: getChildrenViews())
//        return views
//    }
//
//    func getChildrenViews() -> [CheckboxItemView] {
//        var views: [CheckboxItemView] = []
//
//        for node in children {
//            views.append(contentsOf: node.getAllBranchViews())
//        }
//        return views
//    }

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

//    func getVisibleChildViews() -> [CheckboxItemView] {
//        var views: [CheckboxItemView] = []
//
//        for childNode in children {
//            if childNode.item.isGroupCollapsed {
//                views.append(childNode.itemView)
//            } else {
//                views.append(childNode.itemView)
//                views.append(contentsOf: childNode.getVisibleChildViews())
//            }
//        }
//
//        return views
//    }
}
