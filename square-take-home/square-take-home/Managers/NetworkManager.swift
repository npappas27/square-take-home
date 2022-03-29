import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let endpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadEmployees(completed: @escaping (Result<Employees, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completed(.failure(ErrorMessage.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completed(.failure(ErrorMessage.invalidURL)) // fix error message
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(ErrorMessage.invalidResposne)) // fix error message
                return
            }
            guard let data = data else {
                completed(.failure(ErrorMessage.invalidData)) // fix error message
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let employees = try! decoder.decode(Employees.self, from: data)
                completed(.success(employees))
            }
            catch {
                completed(.failure(ErrorMessage.decodingError)) // fix error message
            }
        }
        dataTask.resume()
    }
}
