import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    public let endpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    public let malformedEndpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    public let emptyEndpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadEmployees(from url: String, completed: @escaping (Result<Employees, ErrorMessage>) -> Void) {
        guard let url = URL(string: url) else {
            completed(.failure(ErrorMessage.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completed(.failure(ErrorMessage.invalidURL))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(ErrorMessage.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(ErrorMessage.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let employees = try decoder.decode(Employees.self, from: data)
                completed(.success(employees))
            }
            catch {
                completed(.failure(ErrorMessage.decodingError))
            }
        }
        dataTask.resume()
    }
    
    func downloadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: url) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let response = response as? HTTPURLResponse,
                  response.statusCode == 200, let data = data,
                  let image = UIImage(data: data)
            else {
                      completed(nil)
                      return
                  }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        dataTask.resume()
    }
}
