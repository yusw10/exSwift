//
//  BannerCard.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

struct BannerCard: View {
    var banner: AssetBanner
    var body: some View {
        Color(banner.backgroundColor)
            .overlay{
                VStack{
                    Text(banner.title)
                        .font(.title)
                    Text(banner.description)
                        .font(.subheadline)   
                }
            }
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description: "이곳은 배너 입니다.", backgroundColor: UIColor.blue)
        BannerCard(banner: banner0)
    }
}
