import UIKit

class EmployeeListViewController: UIViewController {
        
    var employees: [Employee] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getData()
        configureNavBar()
    }
    
    func configureNavBar() {
        self.title = "Employees"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))
        refreshButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItems = [refreshButton]
    }
    
    @objc func getData() {
        UIHelper.showLoadingView(view: view)
        NetworkManager.shared.downloadEmployees(from: NetworkManager.shared.endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let allEmployees):
                UIHelper.removeLoadingView()
                guard !allEmployees.employees.isEmpty else {
                    self.showAlertOnMain(title: "No employees", body: "There are no employees")
                    return
                }
                self.employees = allEmployees.employees
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.sortCollectionView()
                }
            case .failure(let error):
                UIHelper.removeLoadingView()
                self.showAlertOnMain(title: "Error", body: error.rawValue)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCell.reuseID, for: indexPath) as! EmployeeCell
        cell.set(employee: self.employees[indexPath.row])
        return cell
    }
    
    func sortCollectionView() {
        employees.sort(by: { $0.team < $1.team })
        collectionView.reloadData()
    }
}
