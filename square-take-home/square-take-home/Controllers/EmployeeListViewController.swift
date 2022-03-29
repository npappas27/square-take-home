import UIKit

class EmployeeListViewController: UIViewController {
        
    var employees: [Employee] = []
    var collectionView: UICollectionView!
    
    var photo = EmployeePhotoView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureView()
        configureCollectionView()
    }
    
    func getData() {
        NetworkManager.shared.downloadEmployees { result in
            switch result {
            case .success(let gotEmployees):
//                print(employees)
                self.employees = gotEmployees.employees
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
    
    func configureView() {
        self.title = "Employees"
        view.backgroundColor = .orange
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self.view))
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBlue
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: EmployeeCell.reuseID)
    }
}


extension EmployeeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !self.employees.isEmpty else { return UICollectionViewCell() }
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCell.reuseID, for: indexPath) as! EmployeeCell
        myCell.set(employee: self.employees[indexPath.row])
        myCell.backgroundColor = UIColor.white
        return myCell
    }
    
    
}
