import UIKit

class EmptyStateView: UIView {
    
    var messageLabel = UILabel(frame: .zero)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //storyboard init
    }
    
    private func configure() {
        configureMessageLabel()

        addSubview(logoImageView)
        addSubview(messageLabel)

        backgroundColor = .systemBackground
        logoImageView.layer.zPosition = 0
        logoImageView.image = UIImage(systemName: "person")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
            
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 400),
            messageLabel.widthAnchor.constraint(equalToConstant: 400),
        
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .label
        messageLabel.font = UIFont.systemFont(ofSize: 24)
        messageLabel.textAlignment = .center
        messageLabel.layer.zPosition = 1
    }
}
