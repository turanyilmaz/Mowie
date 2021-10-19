//
//  CastDetailPresenterTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 3.05.2021.
//

import XCTest
@testable import Mowie

class CastDetailPresenterTests: XCTestCase {
    
    var sut: CastDetailPresenter!

    override func setUpWithError() throws {
        sut = CastDetailPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Spy

    class CastDetailDisplayLogicSpy: CastDetailDisplayLogic {
        
        var displayCastDetailCalled = false
        var displayTitleCalled = false
        var displayItemDetailCalled = false
        var displayErrorAlertCalled = false
        
        func displayErrorAlert(alert: UIAlertController) {
            displayErrorAlertCalled = true
        }
        
        func displayCastDetail(viewModel: CastDetail.GetCast.ViewModel) {
            displayCastDetailCalled = true
        }
        
        func displayTitle(title: String?) {
            displayTitleCalled = true
        }
        
        func displayItemDetail(selectedItem: ItemDetail.SelectedItem?) {
            displayItemDetailCalled = true
        }
    }
    
    //MARK: Tests
    
    func testPresentCastDetail() {
        //Given
        let spy = CastDetailDisplayLogicSpy()
        sut.viewController = spy
        
        //When
        sut.presentCastDetail(response: CastDetailMockData.detailResponse)
        
        //Then
        XCTAssertTrue(spy.displayCastDetailCalled)
    }
    
    func testPresentTitle() {
        //Given
        let spy = CastDetailDisplayLogicSpy()
        sut.viewController = spy
        
        //When
        sut.presentTitle(title: "test")
        
        //Then
        XCTAssertTrue(spy.displayTitleCalled)
    }

}
