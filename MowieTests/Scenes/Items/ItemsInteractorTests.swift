//
//  ItemsInteractorTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 4.05.2021.
//

import XCTest
@testable import Mowie

class ItemsInteractorTests: XCTestCase {
    
    var sut: ItemsInteractor!

    override func setUpWithError() throws {
        sut = ItemsInteractor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    class ItemDetailPresentationLogicSpy: ItemsPresentationLogic {
        
        
        var presentMovieItemsCalled = false
        var presentTVItemsCalled = false
        var presentItemDetailCalled = false
        var presentErrorAlertCalled = false
        
        func presentErrorAlert(error: APIError) {
            presentErrorAlertCalled = true
        }
        
        func presentMovieItems(response: Items.Movie.Response) {
            presentMovieItemsCalled = true
        }
        
        func presentTVItems(response: Items.TV.Response) {
            presentTVItemsCalled = true
        }
        
        func presentItemDetail() {
            presentItemDetailCalled = true
        }
    }
    
    class ItemsWorkerSpy: ItemsWorker {
        override func getMovieItems(request: Items.Movie.Request,
                                    completion: @escaping (Result<Items.Movie.Response, APIError>) -> Void) {
            completion(.success(ItemsMockData.movieResponse))
        }
        
        override func getTVItems(request: Items.TV.Request,
                                 completion: @escaping (Result<Items.TV.Response, APIError>) -> Void) {
            completion(.success(ItemsMockData.tvResponse))
        }
    }
    
    func testGetMovieItems() {
        //Given
        let presenterSpy = ItemDetailPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.worker = ItemsWorkerSpy(itemService: ItemsService())
        
        //When
        sut.getMovieItems()
        
        //Then
        XCTAssertTrue(presenterSpy.presentMovieItemsCalled)
    }
    
    func testGetTVItems() {
        //Given
        let presenterSpy = ItemDetailPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.worker = ItemsWorkerSpy(itemService: ItemsService())
        
        //When
        sut.getTVItems()
        
        //Then
        XCTAssertTrue(presenterSpy.presentTVItemsCalled)
    }
}
