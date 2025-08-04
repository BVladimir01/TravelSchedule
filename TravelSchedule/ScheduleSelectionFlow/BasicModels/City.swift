//
//  City.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

struct City: Hashable, CustomStringConvertible {
    
    let title: String
    let codes: Codes
    
    struct Codes: Hashable {
        let yandex_code: String
    }
    
    var description: String {
        title
    }
    
}
