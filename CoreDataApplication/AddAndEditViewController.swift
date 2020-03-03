import UIKit

class AddAndEditViewController: UIViewController {

    
    private let eventManager = ItemManager()
    private let catManager = CategoryManager()
    
    var eventValue: Event? = nil
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var selectCat: UIButton!
    @IBOutlet weak var placField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    var lastId: Int? = nil
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBg()
        dateField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexspace, donebutton], animated: true)
        dateField.inputAccessoryView = toolbar
        if eventValue != nil {
            needHandler(alert: UIAlertAction(title: selectCat.currentTitle, style: .default, handler: self.needHandler))
        }
    }
    @objc func doneAction(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        dateField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    func setBg(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        if eventValue != nil {
            self.title = eventValue?.name
            titleField.text = eventValue?.name
            descField.text = eventValue?.desc
            selectCat.setTitle((catManager.getCategory(id: Int(eventValue!.categoryId)))?.name, for: .normal)
            placField.text = eventValue?.place
            dateField.text = formatter.string(from: (eventValue?.date)!)
        }
        self.descField.layer.borderWidth = 0.5
        self.descField.layer.borderColor = UIColor.gray.cgColor
        self.descField.layer.cornerRadius = 10
        self.selectCat.layer.cornerRadius = 10
        self.saveButton.layer.cornerRadius = 10
        self.selectCat.layer.shadowColor = UIColor.gray.cgColor
        self.selectCat.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.selectCat.layer.shadowOpacity = 1
    }
    @IBAction func saveFire(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        if (titleField.text?.isEmpty)! || (descField.text?.isEmpty)! {
            createAlert(title: "Warning", message: "Something wrong")
        }
        else if eventValue != nil{
            eventManager.editItem(id: Int(eventValue!.id), name: titleField.text!, desc: titleField.text!, place: descField.text, date: formatter.date(from: dateField.text!)!, categoryId: catManager.getCategory(name: selectCat.currentTitle!)!)
            navigationController?.popViewController(animated: true)
        }
        else {
            let lastId = eventManager.getLastId()! + 1;
            eventManager.addItem(id: lastId, name: titleField.text!, desc: descField.text!, place: placField.text!, date: formatter.date(from: dateField.text!)!, categoryId: catManager.getCategory(name: selectCat.currentTitle!)!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil
        )}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func selectCategory(_ sender: Any) {
        let categories = catManager.getCategories()
        
        let alertController = UIAlertController(title: "Choose category", message: "", preferredStyle: .actionSheet)
        for cat in categories {
            alertController.addAction(UIAlertAction(title: cat.name, style: .default, handler: self.needHandler))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func needHandler(alert: UIAlertAction){
        self.selectCat.setTitle(alert.title, for: .normal)
        selectCat.setTitleColor(UIColor.white, for: .normal)
        if alert.title == "Entertainment"{
            self.selectCat.backgroundColor = #colorLiteral(red: 1, green: 0.5401105881, blue: 0.5554484725, alpha: 1)
        } else if alert.title == "Music"{
            self.selectCat.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.5852756561, alpha: 1)
        } else if alert.title == "Exhibition"{
            self.selectCat.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        } else if alert.title == "Sport"{
            self.selectCat.backgroundColor = #colorLiteral(red: 0.7464560866, green: 0.5540207624, blue: 0.9708413482, alpha: 1)
        }
    }
    
}
