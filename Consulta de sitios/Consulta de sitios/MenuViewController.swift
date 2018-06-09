//
//  MenuViewController.swift
//  Consulta de sitios
//
//  Created by d182_raul_j on 23/03/18.
//  Copyright © 2018 d182_raul_j. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.tableView.reloadData()
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Opcion", for: indexPath)
        let opciones = ["Consulta de sitios", "Configuración", "Acerca de"]
        //let user = users[indexPath.row]
        cell.textLabel?.text = opciones[indexPath.row]
        //cell.detailTextLabel?.text = user.email
        //if let userImage = user.image {
        //    cell.imageView?.image = userImage
        //}
        return cell
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
