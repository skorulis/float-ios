//
//  InventoryModel.swift
//  float-server
//
//  Created by Alexander Skorulis on 26/6/18.
//

public class InventoryStack: Codable {
    let item:ItemModel
    var quantity:Int
    
    public init(item:ItemModel,quantity:Int = 1) {
        self.item = item
        self.quantity = quantity
    }
}

public class InventoryModel: Codable {

    var capacity:Int
    var items:[InventoryStack]
    
    public init() {
        items = []
        capacity = 5
    }
    
}
