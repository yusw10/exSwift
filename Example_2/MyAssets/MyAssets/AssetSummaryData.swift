//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

class AssetSummaryData: ObservableObject {
    @Published var assets: [Asset] = load("assets.json")
    
}

func load<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename + "을 찾을 수 없습니다.")")
    }
    do{
        data = try Data(contentsOf: file)
    }catch{
        fatalError("getting data error")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from:data)
    }catch{
        fatalError("decode error")
    }
}
