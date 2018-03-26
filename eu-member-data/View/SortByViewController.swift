import UIKit

enum SortKey: Int {
    case name
    case area
    case population
    case joinDate
}

enum SortDirection: Int {
    case up
    case down
}

typealias Sort = (key: SortKey, direction: SortDirection)

protocol SortByDelegate {
    func selected(_ sort: Sort)
    func cancelled()
}

class SortByViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate: SortByDelegate?
    
    @IBOutlet weak var sortDirection: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    
    let sortKeys = ["Name", "Area", "Population", "EU join date"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        picker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SortByDelegate implementation
    
    @IBAction func done(_ sender: Any) {
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selectedDirection = sortDirection.selectedSegmentIndex
        
        let sort = (key: SortKey(rawValue: selectedRow)!, direction: SortDirection(rawValue: selectedDirection)!)
        self.delegate?.selected(sort)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.cancelled()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortKeys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortKeys[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

