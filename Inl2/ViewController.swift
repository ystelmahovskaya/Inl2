//
//  ViewController.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-15.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//
//Ni ska göra en app som hanterar recept. Användaren ska kunna lägga till recepten i
//appen med en titel och beskriving över receptets ingredienser och sedan lägga till
//den i appen, som då sedan finns tillgänglig på startsidan. När man dvs klickar på//
//respektive recept på startsidan så kommer man till sidan för själva receptet. Appen
//ska även ha en funktion som raderar ett recept från startsidan. Du ska även ha en
//funktion som sparar ned receptet i Firebase databas.
/*För att erhålla betyget Väl Godkänt krävs det även att det går att välja kategori på
recepten man skapar, på startskärmen ska sedan recepten delas upp och visas i
grupper baserat på deras kategori. Det ska även gå att välja en bild för recepten,
även detta ska synas på startsidan. bild för recepten som syns på startsidan samt
även att du stylar appen med ett GUI. dvs ett grafiskt användargräsnsnitt.
 
 */
import UIKit
import Firebase

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
       // var ref: DatabaseReference!
    var catgories = Array<Category>()
   
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
             // ref = Database.database().reference().child("categories")
        
        let itemSize = UIScreen.main.bounds.width/2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
    layout.itemSize = CGSize(width: itemSize, height: itemSize)
     layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
           DatabaseManager.instance.addCallback(callback: addCategories)   
    }
    
    //observe .childAdded???????
    //    get data as snapshot from db, parse it, observer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
  /*      ref.observe(.value, with: { [weak self] (snapshot) in
            var _catgories = Array<Category>()
            for item in snapshot.children {
                let category = Category(snapshot: item as! DataSnapshot)
                _catgories.append(category)
            }
            self?.catgories = _catgories
            self?.collectionView.reloadData()
        })*/
        
  
        
    }
    
    

    
    func addCategories(category: Category) {
                self.catgories.append(category)
                self.collectionView.reloadData()

//        DatabaseManager.instance.subscribeToChangesOnCatetory(category: category) { (category) in
//            self.catgories.append(category)
//            self.collectionView.reloadData()
//     
//        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        which was created in viewWillAppear
      //  ref.removeAllObservers()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      @IBAction func close(segue:UIStoryboardSegue){}
    
    //number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.catgories.count
    }
    
    //populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //cell.imageView.image
        cell.label.text = catgories[indexPath.row].title
        cell.imageView.downloadedFrom(link: catgories[indexPath.row].imageURL )
        

        
        
        return cell
    }

  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //убирает выдыление пункта после возвращения на основной экран
            collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    //перед переходом на другцю сцену исполняется этот метод  data passing@@
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{ //id of segue to next scene@@
            if let indexPath = collectionView.indexPathsForSelectedItems{
               let destinationViewController = segue.destination as! CategoryDetailViewController // cast to controller where I pass the data@@
                
                    destinationViewController.category = catgories[indexPath[0].row]
            }
        }
    }
}


extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
