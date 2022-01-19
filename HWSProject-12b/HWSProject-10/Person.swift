//
//  Person.swift
//  HWSProject-10
//
//  Created by Владимир on 18.01.2022.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
