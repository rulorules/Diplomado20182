//
//  ClientsTableViewController.swift
//  mytabs
//
//  Created by d182_raul_j on 16/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit
typealias ClientRespones = ([Client]) -> Void

class ClientsTableViewController: UITableViewController {
    var clients = [Client](){
        didSet{
            updateData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClientService { (clients) in
            self.clients = clients
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.clients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell", for: indexPath)
        let client = clients[indexPath.row]
        //ClientCell va en el storyboard
        //cell.textLabel?.text = "YOLO!!"
        cell.textLabel?.text = client.fullName 
        cell.detailTextLabel?.text = "\(client.email) - \(client.gender)"
        //cell.imageView?.image = client.image
        // Configure the cell...

        return cell
    }
    
    func loadClientService(completion: ClientRespones ){
        sleep(2)
        completion(loadClients())
    }
    
    func loadClients() -> [Client] {
        return [
            Client(firstName: "Pepe", lastName: "Guayabas", email: "pepe@guayabas.com",gender: "M"),
            Client(firstName: "Bannana", lastName: "Joe", email: "banana@joe.com",gender: "F"),
            Client(firstName: nil, lastName: nil, email: "pepe@guayabas.com",gender: "F"),
            Client(firstName: "Julio", lastName: nil, email: "pepe@guayabas.com",gender: "F"),
            Client(firstName: nil, lastName: "Wayne", email: "wayne@industries.com",gender: "M"),
        ]
    }
    func updateData() {
        self.tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
