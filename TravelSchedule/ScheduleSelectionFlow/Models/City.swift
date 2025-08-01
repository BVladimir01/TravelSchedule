//
//  City.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

struct City {
    let title: String?
    let codes: Codes
    let stations: [Station]
    
    struct Codes {
        let yandex_code: String?
    }
}
