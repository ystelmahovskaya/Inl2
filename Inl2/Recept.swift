//
//  Recept.swift
//  Inl2
//
//  Created by Yuliia Stelmakhovska on 2017-09-15.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//
import UIKit
import Firebase

struct Recept {
    let title: String
    let imageURL: String
    var ingredients = Array<String>()
    let description: String
    let categoryId:String
    let ref: DatabaseReference?
   
    init(snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
        imageURL = snapshotValue["imageURL"] as! String
      let  ingredientsTMP = snapshotValue["ingredients"] as! [String]
        for ingredient in ingredientsTMP{
        ingredients.append(ingredient)
        }
        description = snapshotValue["description"] as! String
           categoryId = snapshotValue["categoryId"] as! String
        ref = snapshot.ref
        
    }
    init(title: String,imageURL: String, ingredients: Array<String>, description: String, categoryId:String){
        self.title = title
        self.imageURL = imageURL
        self.ingredients = ingredients
        self.description=description
        self.categoryId = categoryId
        self.ref = nil
    
    }
    
    func convertToDictionary()-> Any {
        return ["title": title, "imageURL": imageURL, "description": description, "categoryId": categoryId, "ingredients": ingredients]
    }
}


 
