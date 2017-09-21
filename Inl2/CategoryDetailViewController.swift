//
//  CategoryDetailViewController.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-17.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    //var categoryId:String?
    var category: Category?
  
     //   var recepts = Array<Recept>()

    @IBOutlet weak var receptsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.instance.subscribeToChangesOnCatetory(category: category!) { (category) in
            self.category = category
           
          self.tableView.reloadData()  
        }
 
    }
    override func viewWillAppear(_ animated: Bool) {
       // DatabaseManager.
        
       self.tableView.reloadData()
         }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return (category?.receptList.count)!
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecept", for: indexPath) as! ReceptTableViewCell
        cell.titleLabel.text = category?.receptList[indexPath.row].title
        cell.imageRecept.downloadedFrom(link: (category?.receptList[indexPath.row].imageURL)! )
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecept"{ //id of segue to next scene@@
            if let indexPath =  tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as! ShowReceptViewController // cast to controller where I pass the data@@
                
                destinationViewController.recept = category?.receptList[indexPath[0]]
            }
        }
        if segue.identifier == "addRecept"{ //id of segue to next scene@@
                let destinationViewController = segue.destination as! AddNewReceptTableViewController // cast to controller where I pass the data@@
                
                destinationViewController.categoryID = category?.id
            
        }
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
