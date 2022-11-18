import XCTest
@testable import APCheckboxList

final class APCheckboxListTests: XCTestCase {
    func testItemsCount() throws {
        let list = APCheckboxList()
        
        list.items = [APCheckboxItem(title: "item 1"),
                      APCheckboxItem(title: "item 2")]
        
        XCTAssertEqual(list.items.count, 2)
    }
    
    func testItemSelection() throws {
        let list = APCheckboxList()
        
        let item1 = APCheckboxItem(title: "item 1")
        let item2 = APCheckboxItem(title: "item 2")
        
        list.items = [item1, item2]
        
        item1.isSelected = true
        
        XCTAssertTrue(item1.isSelected)
        XCTAssertFalse(item2.isSelected)
    }
    
    func testGroupSelection() throws {
        let list = APCheckboxList()
        
        let nestedItem1 = APCheckboxItem(title: "nested item 1")
        let nestedItem2 = APCheckboxItem(title: "nested item 2")
        
        let item1 = APCheckboxItem(title: "item 1",
                                   children: [
                                    nestedItem1,
                                    nestedItem2
                                   ])
        let item2 = APCheckboxItem(title: "item 2")
        
        list.items = [item1, item2]
        
        item1.isSelected = true
        
        XCTAssertTrue(nestedItem1.isSelected)
        XCTAssertTrue(nestedItem2.isSelected)
        XCTAssertFalse(item2.isSelected)
    }
    
    func testGroupMixedSelection() throws {
        let list = APCheckboxList()
        
        let nestedItem1 = APCheckboxItem(title: "nested item 1")
        let nestedItem2 = APCheckboxItem(title: "nested item 2")
        
        let item1 = APCheckboxItem(title: "item 1",
                                   children: [
                                    nestedItem1,
                                    nestedItem2
                                   ])
        
        list.items = [item1]
        
        nestedItem1.isSelected = true
        
        XCTAssertTrue(item1.selectionState == .mixed)
        XCTAssertTrue(nestedItem1.isSelected)
        XCTAssertFalse(nestedItem2.isSelected)
    }
}
