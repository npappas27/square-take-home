import UIKit

class EmployeeCell: UICollectionViewCell {
    
    static let reuseID = "EmployeeCell"
    
    let employeePhotoView = EmployeePhotoView(frame: .zero)
    let employeeNameLabel = EmployeeListLabelView(fontSize: 16)
    let employeeTeamLabel = EmployeeListLabelView(fontSize: 16)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // storyboard init
    }
    
    func set(employee: Employee) {
        employeeNameLabel.text = employee.fullName
        employeeTeamLabel.text = employee.team
        employeeTeamLabel.numberOfLines = 0
        if let photoURL = employee.photoUrlSmall {
            employeePhotoView.downloadImage(url: photoURL)
        }
    }
    
    private func configure() {
        addSubview(employeePhotoView)
        addSubview(employeeNameLabel)
        addSubview(employeeTeamLabel)

        NSLayoutConstraint.activate([
            employeePhotoView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            employeePhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeePhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding), // trailing and bottom have to be negative padding
            employeePhotoView.heightAnchor.constraint(equalTo: employeePhotoView.widthAnchor), // constrain width to height to keep things square
            
            employeeNameLabel.topAnchor.constraint(equalTo: employeePhotoView.bottomAnchor, constant: padding),
            employeeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeeNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            employeeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            employeeTeamLabel.topAnchor.constraint(equalTo: employeeNameLabel.bottomAnchor, constant: padding / 2),
            employeeTeamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeeTeamLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            employeeTeamLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
