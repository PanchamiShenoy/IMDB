//
//  RatingView.swift
//  IMDB
//
//  Created by Panchami Shenoy on 4/9/24.
//

import SwiftUI

struct RatingView: View {
    // MARK: - Properties
    var movieRating: Double = 0.0
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .font(.title3)
            Text(String(format: "%.1f/10", movieRating))
                .font(.title3)
        }
    }
}

// MARK: - Preview
#Preview {
    RatingView()
}
