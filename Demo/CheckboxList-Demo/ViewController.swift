//
//  ViewController.swift
//  CheckboxList-Demo
//
//  Created by mac on 09.11.2021.
//

import UIKit
import CheckboxList

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let list = CheckboxList()
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



protocol Nodeable: class {
    associatedtype Value
    var value: Value { get set }
    var next: Self? { get set }
    init(value: Value, next: Self?)
}

// MARK: Extensions

extension Nodeable where Self.Value: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.value == rhs.value }
}

extension Nodeable where Self: AnyObject {
    var retainCount: Int { CFGetRetainCount(self as CFTypeRef) }
}

extension Nodeable where Self: CustomStringConvertible {
    var description: String { return "{ value: \(value), next: \(next == nil ? "nill" : "exist") }" }
}



protocol LinkedListable where Node.Value == Value {
    associatedtype Node: Nodeable
    associatedtype Value
    var firstNode: Node? { get set }
    var lastNode: Node? { get set }
    init()
}

extension LinkedListable {
    var firstValue: Value? { return firstNode?.value }
    var lastValue: Value? { return lastNode?.value }
    var isEmpty: Bool { return firstNode == nil }
}

// MARK: Initializers

extension LinkedListable {
    init(_ array: [Value]) {
        self.init()
        array.forEach { append(newLast: $0) }
    }

    init(copyValuesFrom linkedList: Self) {
        self.init()
        if linkedList.isEmpty { return }
        linkedList.forEachNode { append(newLast: $0.value) }
    }

    init(copyReferencesFrom linkedList: Self) {
        self.init()
        firstNode = linkedList.firstNode
        lastNode = linkedList.lastNode
    }
}

// MARK: Iteration

extension LinkedListable {

    func node(at index: Int) -> Node? {
        if isEmpty { return nil }
        var currentIndex = 0
        var resultNode: Node?
        forEachWhile {
            if index == currentIndex { resultNode = $0; return false }
            currentIndex += 1
            return true
        }
        return resultNode
    }

    func forEachWhile(closure: (Node) -> (Bool)) {
        var currentNode = self.firstNode
        while currentNode != nil {
            guard closure(currentNode!) else { return }
            currentNode = currentNode?.next
        }
    }

    func forEachNode(closure: (Node) -> ()) {
        forEachWhile { closure($0); return true }
    }
}

// MARK: Add/Get values

extension LinkedListable {
    func value(at index: Int) -> Value? { node(at: index)?.value }

    // MARK: Add new node to the end of list

    mutating func append(newLast value: Value) {
        let newNode = Node(value: value, next: nil)
        if firstNode == nil {
            firstNode = newNode
            lastNode = firstNode
        } else {
            lastNode?.next = newNode
            lastNode = lastNode?.next
        }
    }
}


// MARK: CustomStringConvertible

extension LinkedListable where Self: CustomStringConvertible {
    var description: String {
        var values = [String]()
        forEachNode { values.append("\($0.value)") }
        return values.joined(separator: ", ")
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: ExpressibleByArrayLiteral

extension LinkedListable where Self: ExpressibleByArrayLiteral, ArrayLiteralElement == Value {
    init(arrayLiteral elements: Self.ArrayLiteralElement...) { self.init(elements) }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: Sequence

extension LinkedListable where Self: Sequence {
    typealias Iterator = LinkedListableIterator<Node>
    func makeIterator() -> LinkedListableIterator<Node> { return .init(firstNode) }
}

struct LinkedListableIterator<Node>: IteratorProtocol where Node: Nodeable {
    private var currentNode: Node?
    init(_ firstNode: Node?) { self.currentNode = firstNode }
    mutating func next() -> Node.Value? {
        let node = currentNode
        currentNode = currentNode?.next
        return node?.value
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: Collection

extension LinkedListable where Self: Collection, Self.Index == Int, Self.Element == Value {
    var startIndex: Index { 0 }
    var endIndex: Index {
        guard !isEmpty else { return 0 }
        var currentIndex = 0
        forEachNode { _ in currentIndex += 1 }
        return currentIndex
    }

    func index(after i: Index) -> Index { i+1 }
    subscript(position: Index) -> Element { node(at: position)!.value }
    var isEmpty: Bool { return firstNode == nil }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


extension LinkedListable where Self: MutableCollection, Self.Index == Int, Self.Element == Value {

    subscript(position: Self.Index) -> Self.Element {
        get { return node(at: position)!.value }
        set(newValue) { node(at: position)!.value = newValue }
    }
}
