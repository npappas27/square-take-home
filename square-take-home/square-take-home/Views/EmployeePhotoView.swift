import UIKit

class EmployeePhotoView: UIImageView {
    let placeholderImage = UIImage(systemName: "person")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.image = self.placeholderImage
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
