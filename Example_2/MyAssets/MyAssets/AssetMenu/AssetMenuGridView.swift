//
//  AssetMenuGridView.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

struct AssetMenuGridView: View {
    let menuList:[[AssetMenu]] = [
        [.creditScore, .bankAccount, .investment, .loan],
        [.insurance, .creditCard, .cash, .realEstate]
    ]
    var body: some View {
        VStack(spacing: 20){
            ForEach(menuList, id: \.self){ row in
                HStack(spacing: 10){
                    ForEach(row){ menu in
                        Button(""){
                            print("\(menu.title) is tapped")
                        }.buttonStyle(AssetMenuButtonStyle(menu: menu))
                    }
                }
            }
        }
    }
}

struct AssetMenuGridView_Previews: PreviewProvider {
    static var previews: some View {
        
            AssetMenuGridView()
        
    }
}
