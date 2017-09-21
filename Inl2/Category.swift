//
//  Category.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-15.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit
import  Firebase

struct Category{
    let title: String
    let imageURL: String
    var receptList = Array<Recept>()
    var id: String?
  let ref: DatabaseReference?
    
    
    init(title: String, imageURL: String){
    self.title = title
    self.imageURL = imageURL
    self.id = nil
        self.ref = nil
        self.receptList = Array<Recept>()
    }
    
    init(snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
      imageURL = snapshotValue["imageURL"] as! String
             
        ref = snapshot.ref
        self.id = ref?.key
   
    }
    
    func convertToDictionary()-> Any {
        return ["title": title, "imageURL": imageURL]
    }

}
