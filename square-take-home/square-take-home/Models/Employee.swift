import Foundation

struct Employee: Codable {
    var uuid: String
    var fullName: String
    var phoneNumber: String?
    var emailAddress: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    var team: String
    var employeeType: EmployeeType.RawValue
}
