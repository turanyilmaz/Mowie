//
//  CastDetailViewControllerTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 4.05.2021.
//

import XCTest
@testable import Mowie

class CastDetailViewControllerTests: XCTestCase {
    
    var sut: CastDetailViewController!
    var listView: ListView?

    override func setUpWithError() throws {
        sut = CastDetailViewController.instantiateFromStoryboard()
        listView = sut.view.viewWithTag(101) as? ListView
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class CastDetailRoutingLogicSpy: NSObject, CastDetailRoutingLogic, CastDetailDataPassing {
        
        var dataStore: CastDetailDataStore?
        var routeToItemDetailCalled = true
        
        func routeToItemDetail(selectedItem: ItemDetail.SelectedItem?) {
            routeToItemDetailCalled = true
        }
    }

    func testDisplayItemDetail() {
        //Given
        let routerSpy = CastDetailRoutingLogicSpy()
        sut.router = routerSpy
        
        //When
        sut.displayItemDetail(selectedItem: CastDetailMockData.selectedItem)
        
        //Then
        XCTAssertTrue(routerSpy.routeToItemDetailCalled)
    }
    
    func testDisplayCastDetail() {
        //Given
        let routerSpy = CastDetailRoutingLogicSpy()
        sut.router = routerSpy
        
        //When
        sut.displayCastDetail(viewModel: CastDetail.GetCast.ViewModel(listViewModel: CastDetailMockData.listViewModel))
        
        //Then
        XCTAssertTrue(listView?.viewModel != nil)
    }
    
    func testDisplayTitle() {
        //Given
        let title = "test"
        
        //When
        sut.displayTitle(title: title)
        
        //Then
        XCTAssertEqual(sut.title, title)
    }

}
