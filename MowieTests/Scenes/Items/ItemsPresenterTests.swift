//
//  ItemsPresenterTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 4.05.2021.
//

import XCTest
@testable import Mowie

class ItemsPresenterTests: XCTestCase {

    var sut: ItemsPresenter!
    
    override func setUpWithError() throws {
        sut = ItemsPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    class ItemsDisplayLogicSpy: ItemsDisplayLogic {

        var displayItemsCalled = false
        var displayItemDetailCalled = false
        var displayErrorAlertCalled = false
        
        func displayErrorAlert(alert: UIAlertController) {
            displayErrorAlertCalled = true
        }
        
        func displayItems(viewModel: [ItemCollectionViewCellModel]) {
            displayItemsCalled = true
        }
        
        func displayItemDetail() {
            displayItemDetailCalled = true
        }
    }
    
    func testPresentMovieItems() {
        //Given
        let spy = ItemsDisplayLogicSpy()
        sut.viewController = spy
        
        //When
        sut.presentMovieItems(response: ItemsMockData.movieResponse)
        
        //Then
        XCTAssertTrue(spy.displayItemsCalled)
    }
    
    func testPresentTVItems() {
        //Given
        let spy = ItemsDisplayLogicSpy()
        sut.viewController = spy
        
        //When
        sut.presentTVItems(response: ItemsMockData.tvResponse)
        
        //Then
        XCTAssertTrue(spy.displayItemsCalled)
    }
    
    func testPresentItemDetail() {
        //Given
        let spy = ItemsDisplayLogicSpy()
        sut.viewController = spy
        
        //When
        sut.presentItemDetail()
        
        //Then
        XCTAssertTrue(spy.displayItemDetailCalled)
    }

}
