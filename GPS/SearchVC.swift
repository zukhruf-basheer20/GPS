import UIKit
import CoreLocation

protocol SearchVCDelegate: AnyObject {
    func searchViewController(_ vc: SearchVC, didSelectLoactionWith coordinate: CLLocationCoordinate2D?)
    func panal(_ vc: SearchVC)
}
class SearchVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = location[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let coordinate = location[indexPath.row].coordinate
        
        delegate?.searchViewController(self, didSelectLoactionWith: coordinate)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.panal(self)
    }
    

    private let label: UILabel = {
       let label = UILabel()
        label.text = "Search..."
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enetr location to search..."
        field.layer.cornerRadius = 10
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        return field
    }()
    
    private let tableview: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var location = [Location]()
    weak var delegate: SearchVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableview)
        field.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .secondarySystemBackground
        field.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        field.frame = CGRect(x: 10, y: 20 + label.frame.size.height, width: view.frame.size.width - 20, height: 50)
        let tableY: CGFloat = field.frame.origin.y + field.frame.size.height + 5
        tableview.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height - tableY)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLoaction(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.location = locations
                    self?.tableview.reloadData()
                }
            }
        }
        return true
    }
}
