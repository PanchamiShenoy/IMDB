//
//  Trending card.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/8/24.
//

import SwiftUI

struct TrendingCard: View {

    let trendingItem: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: trendingItem.posterPath ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red:61/255,green:61/255,blue:88/255))
                        .frame(width: 340, height: 240)
            }

            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", trendingItem.voteAverage))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red:61/255,green:61/255,blue:88/255))
        }
        .cornerRadius(10)
    }
}
