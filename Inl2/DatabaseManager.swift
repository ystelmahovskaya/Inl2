//
//  DatabaseManager.swift
//
//
//  Created by Yuliia Stelmakhovska on 2017-09-19.
//
//

import UIKit
import Firebase

class DatabaseManager {
    
    private var callbacksCat = [(Category) -> Void]()
    private var callbacksRecept = [(Recept) -> Void]()
    private var _catgories = Array<Category>()
    
    private let ref: DatabaseReference
    private let storageRef: StorageReference
    
    static let instance: DatabaseManager = DatabaseManager()
    
    
    private init() {
        FirebaseApp.configure()
        self.ref = Database.database().reference()
        self.storageRef = Storage.storage().reference()
        
        
        ref.child("categories").observe(.childAdded, with: { [weak self] (snapshot) in
            
            let category = Category(snapshot: snapshot)
            
            //     self?._catgories.append(category)
            for callback in (self?.callbacksCat)! {
                callback(category)
            }
        })
        
    }
    
    func subscribeToChangesOnCatetory(category: Category, callback: @escaping (Category) -> Void) {
        var cat = category
        ref.child("categories").child(category.id!).child("recepts").observeSingleEvent(of: .value, with: { snapshot in
        // I got the expected number of items
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                let recept = Recept(snapshot: rest)
                cat.receptList.append(recept)
            }
            callback(cat)
        }  )
        
    }
/*
 func subscribeToChangesOnCatetory(category: Category, callback: @escaping (Category) -> Void) {
 ref.child("categories").child(category.id!).observe(.childAdded, with: {  [weak self] (snapshot) in
 //parse recepie
 
 //call callback
 
 })
 }
 
 */

func addCallback(callback: @escaping (Category) -> Void) {
    self.callbacksCat.append(callback)
}
//    func addCallbackRecept(callback: @escaping (Recept) -> Void) {
//        self.callbacksRecept.append(callback)
//    }

func addCategory(category: Category) {
    ref.child("categories").childByAutoId().setValue(category.convertToDictionary())
}
func addRecept(recept: Recept, categoryId: String) {
    ref.child("categories").child(categoryId).child("recepts").childByAutoId().setValue(recept.convertToDictionary())
}

func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

func uploadImage(image: UIImage, callback:@escaping ((String) -> Void)) {
    let randomName = self.randomString(length: 10)
    let storageRef = Storage.storage().reference().child("\(randomName).png")
    if let uploadData = UIImagePNGRepresentation(image) {
        
        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
            if error != nil{
                print("error Inl2 \(error?.localizedDescription ?? "no value")")
                return
            }
            let imageURL = metadata?.downloadURL()?.absoluteString
            
            callback(imageURL!)
        })
        
    }
    
    
}

}

