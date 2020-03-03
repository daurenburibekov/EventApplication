import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var labelText: UILabel!
    private let catmanager = CategoryManager()
    private let itemManager = ItemManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        catmanager.addItem(id: 1, name: "Sport")
        catmanager.addItem(id: 2, name: "Entertainment")
        catmanager.addItem(id: 3, name: "Music")
        catmanager.addItem(id: 4, name: "Exhibition")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if itemManager.getItems().isEmpty {
//            labelText.text = "Нету ивентов"
//        }
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.getItems().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.configureCell(event: itemManager.getItems()[indexPath.row])
        return cell
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSecondVCSegue"{
            if let viewController = segue.destination as? NoteViewController, let index = tableView.indexPathForSelectedRow?.row{
                viewController.cellValue = itemManager.getItems()[index]
            }
        }
    }
}

