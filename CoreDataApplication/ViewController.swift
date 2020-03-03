import UIKit

class ViewController: UITableViewController {

    private let catmanager = CategoryManager()
    private let itemManager = ItemManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
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

