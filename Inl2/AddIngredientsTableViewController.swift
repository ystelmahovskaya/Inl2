//
//  AddIngredientsTableViewController.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-18.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class AddIngredientsTableViewController: UIViewController, UITextFieldDelegate,  UITableViewDelegate, UITableViewDataSource {
    var count = 1
     var ingredients = Array<String>()
    var delegate: ModalViewControllerDelegate!
    
    @IBAction func saveIngredientsButtonTapped(_ sender: Any) {
         let cells = self.tableView.visibleCells as! Array<IngredientTableViewCell>
        
        for cell in cells {
            if !(cell.ingredientTextField.text?.isEmpty)!  || cell.ingredientTextField.text != nil {
             self.ingredients.append(cell.ingredientTextField.text!)
            }
        }
        self.dismiss(animated: true) {
            self.delegate!.sendValue(value: self.ingredients)
        }
   }
    
  

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)    }
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentIngredientCell: IngredientTableViewCell?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.tableView.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func didTapView(tapRecognizer: UITapGestureRecognizer) {
        if let cell = self.currentIngredientCell {
            cell.ingredientTextField.endEditing(true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        cell.ingredientTextField.delegate = self
        //cell.ingredientTextField.addTarget(self, action:textFieldDidChange,  for: UIControlEvents.editingChanged)
        return cell
    }
    
    func textFieldDidChange(textField: Selector) {
        self.count+=1
        tableView.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentIngredientCell = textField.superview!.superview as? IngredientTableViewCell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let lastSectionIndex = tableView.numberOfSections-1
        let lastSectionLastRow = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let indexPath = IndexPath(row: lastSectionLastRow, section: lastSectionIndex)
        let cell = tableView.cellForRow(at: indexPath) as! IngredientTableViewCell
        guard  cell.ingredientTextField.text != "" else {
        return
        }
        self.count+=1
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
