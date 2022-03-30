import UIKit

extension UIViewController {
    
    func showAlertOnMain(title: String, body: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
