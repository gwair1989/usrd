//
//  DataUSRD.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import Foundation

struct DataUSRD:Codable {
    let data:[JsonData1]
    let count:Int
 
}

struct JsonData1:Codable {
    let data:JsonDataStep
    let id:String
}

struct JsonDataStep:Codable {
    let step_1:JsonData3
    let step_0:JsonData5
}

struct JsonData3:Codable {
    let data:JsonData4
}


struct JsonData4:Codable {
    let lastname:String
    let firstname:String
    let middlename:String
    let workPlace:String
    let workPost:String
    
}


struct JsonData5:Codable {
    let data:JsonData6
}

struct JsonData6:Codable {
    let declaration_period:String
    
    
}
