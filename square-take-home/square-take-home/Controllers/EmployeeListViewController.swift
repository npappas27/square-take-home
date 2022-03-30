import UIKit

class EmployeeListViewController: UIViewController {
        
    var employees: [Employee] = []
    var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureNavBar()
        configureCollectionView()
    }

    
    func configureNavBar() {
        self.title = "Employees"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))
        navigationItem.rightBarButtonItems = [refreshButton]
    }
    
    
    @objc func getData() {
        NetworkManager.shared.downloadEmployees { result in
            switch result {
            case .success(let gotEmployees):
                self.employees = gotEmployees.employees
                print("more data")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
}


extension EmployeeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self.view))
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: EmployeeCell.reuseID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !self.employees.isEmpty else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCell.reuseID, for: indexPath) as! EmployeeCell
        cell.set(employee: self.employees[indexPath.row])
        cell.backgroundColor = UIColor.white
        return cell
    }
}
