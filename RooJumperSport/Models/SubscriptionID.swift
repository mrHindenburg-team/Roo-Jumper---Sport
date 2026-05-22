enum SubscriptionID: String, CaseIterable {
    case eliteExplosivenessPack = "elite_explosiveness_pack"
    case extremeMotionPack      = "extreme_motion_pack"

    var displayName: String {
        switch self {
        case .eliteExplosivenessPack: "Elite Explosiveness Pack"
        case .extremeMotionPack:      "Extreme Motion Pack"
        }
    }

    var tagline: String {
        switch self {
        case .eliteExplosivenessPack: "Unlock unlimited AI coaching & elite exercises"
        case .extremeMotionPack:      "Unlock premium sport disciplines"
        }
    }

    var features: [String] {
        switch self {
        case .eliteExplosivenessPack:
            [
                "Unlimited AI coach responses",
                "J-Run Pattern — elite high jump technique",
                "Altitude Drop to Jump Shrug — RFD power drill",
                "Band-Assisted Overspeed Jumps — neural speed training"
            ]
        case .extremeMotionPack:
            [
                "Freerunning & parkour advanced modules",
                "Trampoline discipline — air time mastery",
                "Sprint Power mechanics — first-step explosion"
            ]
        }
    }

    var iconName: String {
        switch self {
        case .eliteExplosivenessPack: "bolt.fill"
        case .extremeMotionPack:      "figure.gymnastics"
        }
    }

    var accentColorName: String {
        switch self {
        case .eliteExplosivenessPack: "lime"
        case .extremeMotionPack:      "blue"
        }
    }

    var fallbackPrice: String {
        switch self {
        case .eliteExplosivenessPack: "$1.99"
        case .extremeMotionPack:      "$1.99"
        }
    }
}
