//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by 유한석 on 2022/03/04.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList: [AssetBanner] = [
        AssetBanner(title: "공지사항", description: "공지사항 따위 없다 게이", backgroundColor: UIColor.blue),
        AssetBanner(title: "블루 아카이브", description: "다음 이벤트도 수영복", backgroundColor: UIColor.gray),
        AssetBanner(title: "깜 짝 이 벤 트", description: "칙쇼www", backgroundColor: UIColor.red),
        AssetBanner(title: "캬오오오", description: "으르르르으르으르ㅡ륵", backgroundColor: UIColor.green)
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        let bannerCards = bannerList.map{BannerCard(banner: $0)}
        
        ZStack(alignment: .bottomTrailing){
            PageViewController(pages: bannerCards, currentPage: $currentPage)
            PageControl(numberOfPages: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCards.count * 18), height: 100)
                .padding(.trailing)
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView().aspectRatio(5/2, contentMode: .fit)
    }
}
