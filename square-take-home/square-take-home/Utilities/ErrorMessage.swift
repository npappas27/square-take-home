import Foundation

enum ErrorMessage: String, Error {
    case invalidURL = "The URL is invalid."
    case invalidResponse = "The server returned an invalid response."
    case invalidData = "Invalid data returned from server"
    case decodingError = "Error decoding data"
}
