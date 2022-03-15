//
//  AssetSectionHeaderView.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

struct AssetSectionHeaderView: View {
    let title: String
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.accentColor)
            Divider()// 구분선
                .frame(height: 2)
                .background(Color.primary)
                .foregroundColor(.accentColor)
        }
    }
}

struct AssetSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSectionHeaderView(title: "asd")
    }
}
