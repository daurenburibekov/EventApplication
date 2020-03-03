//
//  FavouritesViewController.swift
//  CoreDataApplication
//
//  Created by Абдинур Куатбек on 2/26/20.
//  Copyright © 2020 Dauren. All rights reserved.
//

import UIKit

class FavouritesViewController: UITableViewController {

    private let catmanager = CategoryManager()
     private let itemManager = ItemManager()
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     override func viewDidAppear(_ animated: Bool) {
         tableView.reloadData()
     }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.getFavItemst(fav: true).count
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
         cell.configureCell(event: itemManager.getFavItemst(fav: true)[indexPath.row])
         return cell
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEventVCSegue"{
            if let viewController = segue.destination as? NoteViewController, let index = tableView.indexPathForSelectedRow?.row{
                viewController.cellValue = itemManager.getFavItemst(fav: true)[index]
            }
        }
    }
}
