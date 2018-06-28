//
//  CityModel.swift
//  App
//
//  Created by Alexander Skorulis on 25/6/18.
//

public class CityModel: Codable {

    public let name:String
    public let width:Int
    public let height:Int
    
    public var squares:[LandPlotModel]
    
    public init(name:String,width:Int,height:Int) {
        self.name = name;
        self.width = width
        self.height = height
        squares = []
        for _ in 0..<(width*height) {
            squares.append(LandPlotModel())
        }
    }
    
    public func getPlot(x:Int,y:Int) -> LandPlotModel {
        let index = y * width + x
        return squares[index]
    }
    
    
}
