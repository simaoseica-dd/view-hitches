/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-Present Datadog, Inc.
 */

import Foundation

struct Product: Identifiable {
    let id: String
    let designerName: String
    let materials: String
    let description: String
    let price: Int
    let rating: Double
    let ratingsCount: Int
    let imageURL: URL
    var isFavorite: Bool
}
