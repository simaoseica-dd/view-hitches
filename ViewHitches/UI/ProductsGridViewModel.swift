/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-Present Datadog, Inc.
 */

import Foundation
import Observation
import UIKit

@Observable
final class ProductsGridViewModel {

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let builder: Builder

    private let startDate = Date()

    private(set) var progress = 0.0
    private(set) var products: [Product] = []

    init(builder: Builder = ProductBuilder()) {

        self.builder = builder

        // Collect info from previous run
        let hitchStats = UserDefaults.standard.string(forKey: "hitchStats") ?? ""
        let threadCount = UserDefaults.standard.string(forKey: "threadCount") ?? ""
        UIPasteboard.general.string = "\(hitchStats)\n\(threadCount)"
    }

    func updateProgress() {
        self.progress = Date().timeIntervalSince(startDate)
    }
    
    func fetchProducts() {
        self.products = (1...1000).map {
            self.builder.build(with: $0)
        }
    }
}

protocol Builder {

    func build(with id: Int) -> Product
}

private class ProductBuilder: Builder {

    func build(with id: Int) -> Product {

        let heavyImageURL: URL = URL(string: "https://picsum.photos/1200/800")!

        let product = Product(
            id: "\(id)",
            designerName: getDesignerName(),
            materials: getMaterials().joined(separator: ", "),
            description: getDescription(),
            price: getPrice(),
            rating: getRating(),
            ratingsCount: getRatingsCount(),
            imageURL: heavyImageURL,
            isFavorite: isFavorite()
        )

        return product
    }
}

private extension ProductBuilder {
    func getDesignerName() -> String {
        let designerNames = [
            "Michael Angelo",
            "Leonardo da Vinci",
            "Pablo Picasso",
            "Coco Chanel",
            "Alexander McQueen",
            "Christian Dior",
            "Yves Saint Laurent",
            "Vivienne Westwood",
            "Karl Lagerfeld",
            "Vera Wang"
        ]
        let randomIndex = Int.random(in: 0..<designerNames.count)
        return designerNames[randomIndex]
    }

    func getMaterials() -> [String] {
        let materials = [
            "Wood",
            "Leather",
            "Metal",
            "Glass",
            "Cotton",
            "Silk",
            "Velvet",
            "Linen",
            "Marble",
            "Brass"
        ]
        return Array(materials.shuffled().prefix(Int.random(in: 2...4)))
    }

    func getDescription() -> String {
        let productDescriptions = [
            "Immerse yourself in the elegance and precision of this finely-crafted masterpiece. Experience the intricate interplay of design elements and the meticulous attention to detail that sets this exceptional product apart from the rest. From the moment you lay eyes on it, you'll be captivated by the harmonious blend of form, function, and aesthetics. Every curve and contour has been meticulously sculpted to create a visually stunning piece that also serves its intended purpose flawlessly. The craftsmanship is evident in every aspect of this creation, from the choice of materials to the skillful execution of each intricate detail. This truly is a work of art that will be cherished for generations to come.",

            "Embark on a journey of unparalleled artistry and craftsmanship with this meticulously designed item. Discover the extraordinary level of care and attention that has gone into every aspect of its creation. From the initial concept to the final product, every step of the process has been guided by a commitment to excellence and a passion for meticulous design. The result is a piece that not only exemplifies beauty and elegance but also showcases the highest standards of quality and sophistication. Each element - be it the carefully selected materials, the intricate patterns, or the precise finishes - has been thoughtfully considered to ensure a truly exceptional product that will stand the test of time.",

            "Dive deep into the world of meticulous design and craftsmanship with this remarkable creation. Witness the sheer artistry and attention to detail that sets this item apart from the ordinary. Each component, no matter how small, has been treated with the utmost care and precision to ensure a seamless blend of functionality and aesthetics. From the moment you interact with it, you'll be enchanted by the tactile experience and the exquisite balance of form and substance. The meticulous craftsmanship is evident in every nook and cranny, from the intricate carvings to the hand-applied finishes. This is more than just a product - it's a testament to the unwavering commitment to excellence and the enduring beauty of meticulously designed objects.",

            "Immerse yourself in the enchanting world of meticulous design with this exceptional masterpiece. Let the intricate details and sophisticated craftsmanship transport you to a realm where elegance and excellence converge. Every aspect of this creation, from the delicately sculpted curves to the meticulously chosen materials, has been orchestrated with utmost care and precision. The result is an awe-inspiring piece that exudes both grace and grandeur. With its captivating presence and attention-demanding allure, this creation is destined to become the centerpiece of any space it graces. Prepare to be captivated by the sheer artistry and unparalleled beauty of this meticulously designed masterpiece.",

            "Experience the epitome of meticulous design and extraordinary craftsmanship with this visually stunning piece. Behold the seamless fusion of form and function, where every line and contour serves a purpose while exuding timeless beauty. Immerse yourself in the sensory delight of the luxurious materials and the painstaking attention to detail that brings this exceptional creation to life. From the handcrafted finishes to the precision-engineered components, each element of this masterpiece has been meticulously crafted to surpass even the highest expectations. This is more than just a product - it's a testament to the enduring artistry of meticulous design and a testament to the power of exceptional craftsmanship."
        ]
        let randomIndex = Int.random(in: 0..<productDescriptions.count)
        return productDescriptions[randomIndex]
    }

    func getRating() -> Double {
        let minimumRating = 1.0
        let maximumRating = 5.0
        return Double.random(in: minimumRating...maximumRating)
    }

    func getRatingsCount() -> Int { Int.random(in: 1...21) }

    func isFavorite() -> Bool { Int.random(in: 1...10) == 1 }

    func getPrice() -> Int { Int.random(in: 10...1000) }
}
