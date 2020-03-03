
import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var removeFromFav: UIButton!
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var label: UITextView!
    @IBOutlet weak var secondDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var moveToTrash: UIBarButtonItem!
    
    let catManager = CategoryManager()
    let eventManager = ItemManager()
    var cellValue: Event? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBg()
    }
    func setBg(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        self.removeFromFav.layer.cornerRadius = 10
        if cellValue != nil{
            self.title = cellValue?.name
            titleLabel.text = cellValue?.name
            label.text = cellValue?.desc
            secondDate.text = formatter.string(from: (cellValue?.date)!)
            typeLabel.text = (catManager.getCategory(id: Int(cellValue!.categoryId)))?.name
            placeLabel.text = cellValue?.place
        }
        if cellValue?.fav != true {
            removeFromFav.setTitle("Add to favourites", for: .normal)
        }
        self.viewAll.layer.cornerRadius = 10
        viewAllbgColor()
    }
    
    func viewAllbgColor(){
        if cellValue!.categoryId == 2{
            self.viewAll.backgroundColor = #colorLiteral(red: 1, green: 0.5401105881, blue: 0.5554484725, alpha: 1)
        } else if cellValue!.categoryId == 3{
            self.viewAll.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.5852756561, alpha: 1)
        } else if cellValue!.categoryId == 4{
            self.viewAll.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        } else if cellValue!.categoryId == 1{
            self.viewAll.backgroundColor = #colorLiteral(red: 0.7464560866, green: 0.5540207624, blue: 0.9708413482, alpha: 1)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToThirdVCSegue"{
            if let viewController = segue.destination as? AddAndEditViewController {
                viewController.eventValue = cellValue
            }
        }
    }
    @IBAction func moveToTrashAct(_ sender: Any) {
        eventManager.deleteItem(id: Int(cellValue!.id))
    navigationController?.popViewController(animated: true)
    }
    @IBAction func removeFromFavAct(_ sender: Any) {
        eventManager.changeFav(id: Int(cellValue!.id))
    }
    
}
