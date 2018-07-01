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
    
}
