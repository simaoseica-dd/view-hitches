/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-Present Datadog, Inc.
 */

import Foundation
import SwiftUI

struct ProductCardView: View {
    
    var product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {

                AsyncImage(url: product.imageURL)
                    .scaledToFill()
                    .frame(width: 180, height: 140)
                    .clipped()

                Button(action: { }) {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .padding(8)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.designerName)
                    .font(.subheadline)

                Text("Product ID: #\(product.id)")
                    .font(.caption2)
                    .foregroundColor(.gray)

                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                            .resizable()
                            .foregroundColor(index < Int(product.rating) ? .black : .gray)
                            .frame(width: 10, height: 10)
                    }
                    Text("(\(product.ratingsCount))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }

                Text("Designer")
                    .font(.caption)
                    .bold()
                Text(product.designerName)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Materials & Finishes")
                    .font(.caption)
                    .bold()
                Text(product.materials)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("$\(String(format: "%d", product.price)).00")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)

                Button(action: { }) {
                    Text("Add to cart")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(10)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 5)
            }
            .padding(8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
