/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-Present Datadog, Inc.
 */

import DatadogRUM
import Foundation
import SwiftUI

struct ProductsGridView: View {

    @State private var viewModel = ProductsGridViewModel()

    private let columns: [GridItem] = [
        GridItem(.fixed(160), spacing: 10, alignment: .topTrailing),
        GridItem(.fixed(160), spacing: 10, alignment: .topLeading)
    ]

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                VStack {

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(0..<self.viewModel.products.count, id: \.self) { i in
                                ProductCardView(product: self.viewModel.products[i])
                            }
                            .padding(.bottom, 10)
                        }
                        .padding()
                    }
                }
                .navigationTitle("Products")
                .onReceive(viewModel.timer) { _ in

                    viewModel.updateProgress()

                    withAnimation(.easeInOut(duration: 0.5)) {
                        proxy.scrollTo(Int(viewModel.progress))
                    }
                }
                .onAppear() {

                    viewModel.fetchProducts()
                }
                .trackRUMView(name: "Products Grid")
            }
        }
    }
}

#Preview {
    ProductsGridView()
}
