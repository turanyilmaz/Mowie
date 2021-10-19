//
//  ItemsViewControllerTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 4.05.2021.
//

import XCTest
@testable import Mowie

class ItemsViewControllerTests: XCTestCase {
    
    var sut: ItemsViewController!

    override func setUpWithError() throws {
        sut = ItemsViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    class ItemsRoutingLogicSpy: NSObject, ItemsRoutingLogic, ItemsDataPassing {
        var dataStore: ItemsDataStore?
        
        var routeToItemDetailCalled = false
        
        func routeToItemDetail() {
            routeToItemDetailCalled = true
        }
    }
    
    func testDisplayItemDetail() {
        //Given
        let routerSpy = ItemsRoutingLogicSpy()
        sut.router = routerSpy
        
        //When
        sut.displayItemDetail()
        
        //Then
        XCTAssertTrue(routerSpy.routeToItemDetailCalled)
    }

}
