//
//  ApiStructsMapper.swift
//  TravelSchedule
//
//  Created by Vladimir on 01.08.2025.
//

// MARK: - APIStructsMapper
struct APIStructsMapper {
    
    // MARK: - Types
    
    typealias APICity = Components.Schemas.Settlement
    typealias APIStation = Components.Schemas.Station
    
    // MARK: - Internal Methods
    
    func map(city: APICity) -> City? {
        guard let title = city.title, let yandexCode = city.codes?.yandex_code else {
            return nil
        }
        return City(title: title,
                    codes: City.Codes(yandex_code: yandexCode))
    }
    
    func map(station: APIStation) -> Station? {
        guard let title = station.title, let yandexCode = station.codes?.yandex_code else {
            return nil
        }
        return Station(title: title,
                       codes: Station.Codes(esr_code: station.codes?.esr_code,
                                            yandex_code: yandexCode))
    }
    
}
