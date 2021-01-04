//
//  River.swift
//  River Meter
//
//  Created by Ognjen Tomic on 31.12.20..
//

import Foundation


struct River: Identifiable, Codable, Equatable, Hashable {
    
    let id: UUID
    var riverTitleFetchedFromXML: String
    var descriptionFetchedFromXML: String
    var riverName:String {
        let riverMeasurmentPlace = riverTitleFetchedFromXML.components(separatedBy: ":")
        var riverSplitedStringFromFetchedXML = ""
        for i in 0 ..< riverMeasurmentPlace.count {
            if i == 1 {
                riverSplitedStringFromFetchedXML = riverMeasurmentPlace[i]
            }
        }
        var riverName = ""
        let rivers = riverSplitedStringFromFetchedXML.components(separatedBy: "-")
        for i in 0 ..< rivers.count {
            if i == 0 {
                riverName = rivers[i]
            }
        }
        return riverName
        
    }
    var riverPlace:String {
        let riverMeasurmentPlace = riverTitleFetchedFromXML.components(separatedBy: ":")
        var riverPlace = ""
        
        for i in 0 ..< riverMeasurmentPlace.count {
            if i == 2 {
                riverPlace = riverMeasurmentPlace[i]
            }
        }
        
        return riverPlace
        
    }
    
    var riverNames:[String] {
        var riverNames = [String]()
        let riverMeasurmentPlace = riverTitleFetchedFromXML.components(separatedBy: ":")
        
        var riverSplitedStringFromFetchedXML = ""
        for i in 0 ..< riverMeasurmentPlace.count {
            if i == 1 {
                riverSplitedStringFromFetchedXML = riverMeasurmentPlace[i]
            }
        }
        let rivers = riverSplitedStringFromFetchedXML.components(separatedBy: "-")
        
        rivers.removeDuplicate()
        riverNames = rivers
        
        return riverNames
    }
    
    static let `default` = River(riverTitle: "Dunav", description: "bla bla")
    let reservedRiverForPreview: String = "Dunav"

    
    internal init(id: UUID = UUID(), riverTitle: String, description: String) {
        self.riverTitleFetchedFromXML = riverTitle
        self.descriptionFetchedFromXML = description
        self.id = id
    }
    
    
}


extension River {
    static var riverPreviewListData: [River] {
        [
            River(riverTitle: "Dunav", description: "Vodostaj na dan: 31.12. ČETVRTAK 105 cm; Prognoza vodostaja: 01.01. PETAK 106 cm; 02.01. SUBOTA 110 cm; 03.01. NEDELJA 120 cm; 04.01. PONEDELJAK 123 cm; Redovna odbarana: 500 cm; Vanredna odbrana: 700 cm;"),
            River(riverTitle: "Sava", description: "Vodostaj na dan: 31.12. ČETVRTAK 159 cm; Prognoza vodostaja: 01.01. PETAK 160 cm; 02.01. SUBOTA 165 cm; 03.01. NEDELJA - cm; 04.01. PONEDELJAK - cm; Redovna odbarana: 600 cm; Vanredna odbrana: 750 cm;"),
            River(riverTitle: "Tisa", description: "VVodostaj na dan: 31.12. ČETVRTAK 164 cm; Prognoza vodostaja: 01.01. PETAK 175 cm; 02.01. SUBOTA 184 cm; 03.01. NEDELJA 202 cm; 04.01. PONEDELJAK 207 cm; Redovna odbarana: 600 cm; Vanredna odbrana: 700 cm;"),
        ]
    }
    
}

