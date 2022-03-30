import UIKit

class AlertViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let errorMessageLabel = UILabel()
    let actionButton = UIButton()
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        turnAutoLayoutOff()
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
    }
    
    private func turnAutoLayoutOff() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding), // trailing and bottom are negative
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.backgroundColor = .red
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding), // negative for trailing and bottom
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(errorMessageLabel)
        errorMessageLabel.text = message ?? "Unable to complete request"
        errorMessageLabel.numberOfLines = 4 // ?
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            errorMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            errorMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            errorMessageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC() {
       dismiss(animated: true)
    }
}
