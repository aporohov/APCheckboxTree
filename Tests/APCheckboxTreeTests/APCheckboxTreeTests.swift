import XCTest
@testable import APCheckboxTree

final class APCheckboxTreeTests: XCTestCase {
    func testItemsCount() throws {
        let tree = APCheckboxTree()
        
        tree.items = [APCheckboxItem(title: "item 1"),
                      APCheckboxItem(title: "item 2")]
        
        XCTAssertEqual(tree.items.count, 2)
    }
    
    func testItemSelection() throws {
        let tree = APCheckboxTree()
        
        let item1 = APCheckboxItem(title: "item 1")
        let item2 = APCheckboxItem(title: "item 2")
        
        tree.items = [item1, item2]
        
        item1.isSelected = true
        
        XCTAssertTrue(item1.isSelected)
        XCTAssertFalse(item2.isSelected)
    }
    
    func testGroupSelection() throws {
        let tree = APCheckboxTree()
        
        let nestedItem1 = APCheckboxItem(title: "nested item 1")
        let nestedItem2 = APCheckboxItem(title: "nested item 2")
        
        let item1 = APCheckboxItem(title: "item 1",
                                   children: [
                                    nestedItem1,
                                    nestedItem2
                                   ])
        let item2 = APCheckboxItem(title: "item 2")
        
        tree.items = [item1, item2]
        
        item1.isSelected = true
        
        XCTAssertTrue(nestedItem1.isSelected)
        XCTAssertTrue(nestedItem2.isSelected)
        XCTAssertFalse(item2.isSelected)
    }
    
    func testGroupMixedSelection() throws {
        let tree = APCheckboxTree()
        
        let nestedItem1 = APCheckboxItem(title: "nested item 1")
        let nestedItem2 = APCheckboxItem(title: "nested item 2")
        
        let item1 = APCheckboxItem(title: "item 1",
                                   children: [
                                    nestedItem1,
                                    nestedItem2
                                   ])
        
        tree.items = [item1]
        
        nestedItem1.isSelected = true
        
        XCTAssertTrue(item1.selectionState == .mixed)
        XCTAssertTrue(nestedItem1.isSelected)
        XCTAssertFalse(nestedItem2.isSelected)
    }
}
