//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Deepthi Rao on 8/23/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // WeatherApp viewModel tests
    func testViewModelInit() {
        let viewModel = WeatherViewModel()
        XCTAssertTrue(viewModel.showAlert == false)
        XCTAssertTrue(viewModel.showErrorMessage.isEmpty == true)
        XCTAssertTrue(viewModel.model == nil)
    }

    func testViewModelUpdate() {
        let viewModel = WeatherViewModel()
        XCTAssertTrue(viewModel.showAlert == false)
        XCTAssertTrue(viewModel.showErrorMessage.isEmpty == true)
        XCTAssertTrue(viewModel.model == nil)
        
        viewModel.showAlert = true
        viewModel.showErrorMessage = "Test message"
        XCTAssertTrue(viewModel.showAlert == true)
        XCTAssertTrue(viewModel.showErrorMessage.isEmpty == false)
        XCTAssertTrue(viewModel.showErrorMessage == "Test message")
    }
    
    // WeatherLocationManager test
    func testWeatherLocationManager() {
        let location = WeatherLocationManager()
        XCTAssertTrue(location.currentLocation == "")
    }
}
