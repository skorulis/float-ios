//
//  ItemModel.swift
//  float-server
//
//  Created by Alexander Skorulis on 26/6/18.
//

public class ItemModel: Codable {
 
    let ref:ItemReferenceModel
    var quantity:Int
    
    init(ref:ItemReferenceModel,quantity:Int = 1) {
        self.ref = ref
        self.quantity = quantity
    }
    
}
