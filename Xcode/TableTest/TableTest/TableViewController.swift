//
//  TableViewController.swift
//  TableTest
//
//  Created by d182_raul_j on 26/05/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var alumnos = ["Julio", "Parra", "German", "Roberto", "Luis", "Pedro","Julio", "Parra", "German", "Roberto", "Luis", "Pedro","Julio", "Parra", "German", "Roberto", "Luis", "Pedro","Julio", "Parra", "German", "Roberto", "Luis", "Pedro"]
    var borrado = "ad"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alumnos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = alumnos[indexPath.row]
//        if cell.accessoryType == .checkmark{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Bórrame") { (action, sourceView, completionHandler) in
            self.borrado = self.alumnos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Compartir") { (action, sourceView, completionHandler) in
            let message = "Compartiendo al alumno: " + self.alumnos[indexPath.row]
            
            let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
            //Para que no crashee el popover(activityController) en el ipad
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254/255, green: 149/255, blue: 38/255, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction,deleteAction])
        
        return swipeConfiguration
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Bórrame") { (action, sourceView, completionHandler) in
            self.alumnos.append(self.borrado)
            self.tableView.reloadData()
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
    }
    
    
    //Para quitar el icono de borrar, sobreescribimos su metodo
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    //Para quitar la identacion sobreescribimos el metodo
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //Para poner la hamburguesa de mover los elementos de la lista
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedAlumno = self.alumnos[sourceIndexPath.row]
        
        self.alumnos.remove(at: sourceIndexPath.row)
        self.alumnos.insert(movedAlumno, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let rowData = self.alumnos[indexPath.row]
        return rowData.hasPrefix("P")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Marcando alumnos", message: "¿Desea marcarlo?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark{
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController,animated: true,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.0, animations: {cell.alpha = 1})
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let rotationAngleinRadians = 90 * CGFloat(M_PI/180.0)
//        //let rotationTransform = CATransform3DMakeRotation(rotationAngleinRadians, 0, 0, 1)
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
//        
//        
//        cell.layer.transform = rotationTransform
//        UIView.animate(withDuration: 1.0){
//            cell.layer.transform = CATransform3DIdentity
//        }
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            alumnos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
