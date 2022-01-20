
import XCTest
@testable import Atas_Ram_Task

class Atas_Ram_TaskTests: XCTestCase {
    var vc: HomeDetailsViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    override func setUp() {
        vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeDetailsViewController") as? HomeDetailsViewController
               _ = vc.view
        let workerSpy = MockAPIManager.sharedManager
        vc.viewModel = HomeDetailsViewModel(apimanager: workerSpy)


    }
    // Tests for api responce using Mock data
    func testPresentationListsResponce() {
        vc.viewModel.getWeatherResults(withLat: 14.540917, withLong: 79.593251, withExclude: "") { (status, message) in
            XCTAssertTrue(status)
            XCTAssertNotNil(self.vc.viewModel.weatherData)
        }
    }

    func testPresentationListsResponceNil() {
        vc.viewModel.getWeatherResults(withLat: 14.540917, withLong: 79.593251, withExclude: "") { (status, message) in
            XCTAssertTrue(status)
            XCTAssertNotNil(self.vc.viewModel.weatherData)
            XCTAssertEqual(self.vc.viewModel.weatherData?.lat, 14.5409)
            XCTAssertEqual(self.vc.viewModel.weatherData?.lon, 79.5933)
            XCTAssertEqual(self.vc.viewModel.weatherData?.timezone, "Asia/Kolkata")
        }
    }

    func testPresentationListsResponceDaily() {
        vc.viewModel.getWeatherResults(withLat: 14.540917, withLong: 79.593251, withExclude: "") { (status, message) in
                XCTAssertTrue(status)
                XCTAssertNotNil(self.vc.viewModel.weatherData?.daily)
                XCTAssertEqual(self.vc.viewModel.weatherData?.daily?.count, 8)
        }
    }

    func testPresentationListsResponceHourly() {
        vc.viewModel.getWeatherResults(withLat: 14.540917, withLong: 79.593251, withExclude: "") { (status, message) in
                XCTAssertTrue(status)
                XCTAssertNotNil(self.vc.viewModel.weatherData?.hourly)
                XCTAssertEqual(self.vc.viewModel.weatherData?.hourly?.count, 48)
        }
    }

    func testPresentationListsResponceMinutely() {
        vc.viewModel.getWeatherResults(withLat: 14.540917, withLong: 79.593251, withExclude: "") { (status, message) in
                XCTAssertTrue(status)
                XCTAssertNotNil(self.vc.viewModel.weatherData?.minutely)
                XCTAssertEqual(self.vc.viewModel.weatherData?.minutely?.count, 61)
        }
    }
}

