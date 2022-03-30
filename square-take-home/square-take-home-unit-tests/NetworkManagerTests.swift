import XCTest
@testable import square_take_home

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager.shared
    }
    
    func testGetEmployeesFromValidEndpoint() {
        let promise = expectation(description: "Got employees from API")
        sut.downloadEmployees(from: sut.endpoint) { result in
            switch result {
            case .success(_):
                promise.fulfill()
            case .failure(_):
                XCTFail("Failed getting employees from endpoint")
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testValidEndpointHasCorrectNumberOfEmployees() {
        let promise = expectation(description: "Employee array has correct value of 11")
        sut.downloadEmployees(from: sut.endpoint) { result in
            switch result {
            case .success(let employees):
                if (employees.employees.count == 11) { promise.fulfill() }
            case .failure(_):
                XCTFail("Failed getting employees from endpoint")
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testMalformedEmloyeesJSONShouldFail() {
        let promise = expectation(description: "Invalid JSON")
        sut.downloadEmployees(from: sut.malformedEndpoint) { result in
            switch result {
            case .success(_):
                XCTFail("Malformed JSON was formatted correctly..?")
            case .failure(_):
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testMalformedEmloyeesJSONShouldHaveZeroEmployees() {
        let promise = expectation(description: "Malformed JSON returns 0 employees")
        sut.downloadEmployees(from: sut.malformedEndpoint) { result in
            switch result {
            case .success(_):
                XCTFail("Malformed JSON was formatted correctly..?")
            case .failure(_):
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testEmptyEmployeesJSONShouldReturnZeroEmployees() {
        let promise = expectation(description: "Empty JSON returns 0 employees")
        sut.downloadEmployees(from: sut.emptyEndpoint) { result in
            switch result {
            case .success(let employees):
                if (employees.employees.count == 0) { promise.fulfill() }
            case .failure(_):
                XCTFail("Failed getting employees from endpoint")
            }
        }
        wait(for: [promise], timeout: 1)
    }
}
