//
//  ApiStructsMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

struct APIStructsMapper {
    
    typealias APICity = Components.Schemas.Settlement
    typealias APIStation = Components.Schemas.Station
    
    func map(city: APICity) -> City {
        City(title: city.title,
             codes: City.Codes(yandex_code: city.codes?.yandex_code),
             stations: city.stations?.map { map(station: $0) } ?? [])
    }
    
    private func map(station: APIStation) -> Station {
        Station(title: station.title,
                       codes: Station.Codes(esr_code: station.codes?.esr_code,
                                            yandex_code: station.codes?.yandex_code))
    }
    
}
