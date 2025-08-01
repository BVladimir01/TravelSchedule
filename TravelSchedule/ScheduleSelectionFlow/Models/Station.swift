//
//  Station.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

struct Station: Hashable {
    
    var title: String?
    var codes: Codes
    
    struct Codes: Hashable {
        var esr_code: String?
        var yandex_code: String?
    }
    
}
