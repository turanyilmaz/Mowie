//
//  CastDetailInteractorTests.swift
//  MovilienTests
//
//  Created by Turan Yilmaz on 3.05.2021.
//

import XCTest
@testable import Mowie

class CastDetailInteractorTests: XCTestCase {
    
    var sut: CastDetailInteractor!

    override func setUpWithError() throws {
        sut = CastDetailInteractor()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Spy
    
    class CastDetailWorkerSpy: CastDetailWorker {
        override func getCastDetail(request: CastDetail.GetCast.Request,
                                    completion: @escaping (Result<CastDetail.GetCast.Response, APIError>) -> Void) {
            
            completion(.success(CastDetailMockData.detailResponse))
        }
    }
    
    class CastDetailPresenterSpy: CastDetailPresentationLogic {
        
        var presentErrorAlertCalled = false
        var presentCastDetailCalled = false
        var presentTitleCalled = false
        
        func presentErrorAlert(error: APIError) {
            presentErrorAlertCalled = true
        }
        
        func presentCastDetail(response: CastDetail.GetCast.Response) {
            presentCastDetailCalled = true
        }
        
        func presentTitle(title: String?) {
            presentTitleCalled = true
        }
    }

    //MARK: Tests
    
    func testGetCastDetail() {
        //Given
        let presenterSpy = CastDetailPresenterSpy()
        sut.presenter = presenterSpy
        sut.worker = CastDetailWorkerSpy(castDetailService: CastDetailService())
        
        //When
        sut.getCastDetail()
        
        //Then
        XCTAssertTrue(presenterSpy.presentCastDetailCalled)
    }
    
    func testSetTitle() {
        //Given
        let presenterSpy = CastDetailPresenterSpy()
        sut.presenter = presenterSpy
        sut.worker = CastDetailWorkerSpy(castDetailService: CastDetailService())
        
        //When
        sut.setTitle()
        
        //Then
        XCTAssertTrue(presenterSpy.presentTitleCalled)
    }

}
