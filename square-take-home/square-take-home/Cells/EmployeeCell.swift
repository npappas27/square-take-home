import UIKit

class EmployeeCell: UICollectionViewCell {
    
    static let reuseID = "EmployeeCell"
    
    let employeePhotoView = EmployeePhotoView(frame: .zero)
    let employeeNameLabel = UILabel(frame: .zero)
    let employeeTeamLabel = UILabel(frame: .zero)
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
//        employeePhotoView.downloadImage(url: employee.photoUrlSmall)
    }
    
    private func configure() {
        addSubview(employeePhotoView)
        addSubview(employeeNameLabel)
        addSubview(employeeTeamLabel)
        
        employeeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        employeeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        employeeNameLabel.textAlignment = .center
        

        NSLayoutConstraint.activate([
            employeePhotoView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            employeePhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeePhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding), // trailing and bottom have to be negative padding
            employeePhotoView.heightAnchor.constraint(equalTo: employeePhotoView.widthAnchor), // constrain width to height to keep things square
            
            employeeNameLabel.topAnchor.constraint(equalTo: employeePhotoView.bottomAnchor, constant: padding),
            employeeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeeNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            employeeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            employeeTeamLabel.topAnchor.constraint(equalTo: employeeNameLabel.bottomAnchor, constant: padding),
            employeeTeamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            employeeTeamLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            employeeTeamLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
