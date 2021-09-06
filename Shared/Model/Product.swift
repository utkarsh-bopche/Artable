//
//  Product.swift
//  Artable
//
//  Created by Thinkitive on 04/09/21.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id : String
    var category : String
    var price : Double
    var productDescription: String
    var imageUrl : String
    var timeStamp : Timestamp
    var stock : Int
    var favorite : Bool
}
