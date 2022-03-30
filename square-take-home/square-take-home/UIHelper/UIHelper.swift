import UIKit

fileprivate var containerView: UIView!

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpace: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)
        return flowLayout
    }
    
    
    static func showLoadingView(view: UIView) {
        DispatchQueue.main.async {
            containerView = UIView(frame: view.bounds)
            view.addSubview(containerView)
            containerView.backgroundColor = .systemBackground
            containerView.alpha = 0
            UIView.animate(withDuration: 0.25) {
                containerView.alpha = 0.8
            }
            let activityIndicator = UIActivityIndicatorView(style: .large)
            containerView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
            activityIndicator.startAnimating()
        }
    }
    
    static func removeLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    }
    
}
