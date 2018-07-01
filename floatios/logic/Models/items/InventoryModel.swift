//
//  InventoryModel.swift
//  float-server
//
//  Created by Alexander Skorulis on 26/6/18.
//

public class InventoryModel: Codable {

    var capacity:Int
    var items:[ItemModel]
    
    public init() {
        items = []
        capacity = 5
    }
    
    func hasItem(name:String,quantity:Int) -> Bool {
        guard let item = findItem(name: name) else { return false }
        return item.quantity >= quantity
    }
    
    func findItem(name:String) -> ItemModel? {
        return items.filter { $0.ref.name == name}.first
    }
    
}
