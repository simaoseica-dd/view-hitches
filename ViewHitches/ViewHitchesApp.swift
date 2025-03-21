/*
 * Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
 * This product includes software developed at Datadog (https://www.datadoghq.com/).
 * Copyright 2019-Present Datadog, Inc.
 */

import DatadogCore
import DatadogRUM
import SwiftUI

@main
struct ViewHitchesApp: App {

    init() {
        let appID = ""
        let clientToken = ""
        let environment = ""

        Datadog.initialize(
            with: .init(clientToken: clientToken, env: environment),
            trackingConsent: .granted
        )

        RUM.enable(
            with: RUM.Configuration(
                applicationID: appID,
                featureFlags: [.viewHitches: true]
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            ProductsGridView()
        }
    }
}
