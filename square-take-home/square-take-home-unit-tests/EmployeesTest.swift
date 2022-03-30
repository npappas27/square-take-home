import XCTest
@testable import square_take_home


class EmployeeTest: XCTestCase {
    
    func testEmployeesCodable() throws {
        let expected = [Employee(uuid: "2192206e-05c6-4118-a82f-e51762f06a5e", fullName: "Nick Pappas", phoneNumber: "330-861-9665", emailAddress: "njpappas97@gmail.com", biography: "Vestibulum varius justo et dui suscipit tempus. Etiam a arcu eget augue semper facilisis eget non mauris. Integer malesuada lectus et massa efficitur, ut lacinia quam condimentum.", photoUrlSmall: "https://avatars.githubusercontent.com/u/19754084?v=4", photoUrlLarge: "https://avatars.githubusercontent.com/u/19754084?v=4", team: "Slytherin", employeeType: EmployeeType.FULL_TIME.rawValue)]
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try encoder.encode(expected)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode([Employee].self, from: encoded)
        
        XCTAssertEqual(decoded, expected)
    }
    
    func testEmployeeCodable() throws {
        let expected = Employee(uuid: "2192206e-05c6-4118-a82f-e51762f06a5e", fullName: "Nick Pappas", phoneNumber: "330-861-9665", emailAddress: "njpappas97@gmail.com", biography: "Vestibulum varius justo et dui suscipit tempus. Etiam a arcu eget augue semper facilisis eget non mauris. Integer malesuada lectus et massa efficitur, ut lacinia quam condimentum.", photoUrlSmall: "https://avatars.githubusercontent.com/u/19754084?v=4", photoUrlLarge: "https://avatars.githubusercontent.com/u/19754084?v=4", team: "Slytherin", employeeType: EmployeeType.FULL_TIME.rawValue)
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try encoder.encode(expected)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(Employee.self, from: encoded)
        
        XCTAssertEqual(decoded, expected)
    }
}
