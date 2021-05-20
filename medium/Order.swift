//
//  Order.swift
//  medium
//
//  Created by Mesut Aygün on 20.05.2021.
//

import Foundation

class Order : ObservableObject , Codable {
    
    enum CodingKeys : CodingKey {
        case type , quantity , extraForesting ,Adress, addSprinkles , name , lastName , Zip
    }
    
    static let types = ["vanilla","strawberry","chocolate","rainbow"]
    
    @Published var type = 0
    
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraForesting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraForesting = false
    
    @Published var addSprinkles = false
    
    @Published var name = String()
    
    @Published var lastName = String()
    
    @Published var Adress = String()
    
    @Published var Zip = String()
    
    
    
    var cost : Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(quantity) / 2)
        
        if extraForesting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    init() {
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraForesting = try container.decode(Bool.self, forKey: .extraForesting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        Adress = try container.decode(String.self, forKey: .Adress)
    
        Zip = try container.decode(String.self, forKey: .Zip)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraForesting, forKey: .extraForesting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        
        try container.encode(Adress, forKey: .Adress)
       
        try container.encode(Zip, forKey: .Zip)
    }
}
