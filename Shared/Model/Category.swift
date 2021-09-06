//
//  Category.swift
//  Artable
//
//  Created by Thinkitive on 02/09/21.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name : String
    var id : String
    var imageUrl : String
    var isActive : Bool = true
    var timeStamp: Timestamp
    
    init(data: [String : Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
