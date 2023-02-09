//
//  Data.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 03.02.2023.
//

import Foundation

class DataShights {
    
    static let shared  = DataShights()
    
    func getSights() -> [Sight] {
        
        let sights = [Sight(sightImage: "typhoon",
                            sightText: "Наиболее заметной достопримечательностью города является 310-метровая метеорологическая мачта, входящая в метеокомплекс НПО «Тайфун»."),
                      Sight(sightImage: "school",
                            sightText: "На Морозовской даче, которую до Великой Отечественной войны занимала Школа-колония Шацкого «Бодрая жизнь», в 1942 находился командный пункт командующего Западным фронтом."),
                      Sight(sightImage: "tower",
                            sightText: "Старая водонапорная башня в Старом Городе (снос и использование в коммерческих целях запрещены).")]
        
        return sights
    }
    
}
