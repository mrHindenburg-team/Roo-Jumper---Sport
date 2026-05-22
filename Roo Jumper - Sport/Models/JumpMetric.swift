import Foundation

struct JumpMetric: Identifiable {
    let id: UUID
    let date: Date
    let type: MetricType
    let value: Double

    init(type: MetricType, value: Double) {
        self.id    = UUID()
        self.date  = Date.now
        self.type  = type
        self.value = value
    }

    var unit: String { type.unit }

    enum MetricType: String, CaseIterable {
        case verticalJump        = "Vertical Jump"
        case standingBroadJump   = "Standing Broad Jump"
        case reactionTime        = "Reaction Time"
        case explosiveness       = "Explosiveness Score"
        case airTime             = "Air Time"
        case consistencyScore    = "Consistency Score"

        var unit: String {
            switch self {
            case .verticalJump, .standingBroadJump: "cm"
            case .reactionTime:                     "ms"
            case .explosiveness, .consistencyScore: "pts"
            case .airTime:                          "sec"
            }
        }

        var iconName: String {
            switch self {
            case .verticalJump:      "arrow.up.circle.fill"
            case .standingBroadJump: "arrow.right.circle.fill"
            case .reactionTime:      "bolt.fill"
            case .explosiveness:     "flame.fill"
            case .airTime:           "wind"
            case .consistencyScore:  "star.fill"
            }
        }

        var accentColor: String {
            switch self {
            case .verticalJump:      "lime"
            case .standingBroadJump: "blue"
            case .reactionTime:      "orange"
            case .explosiveness:     "orange"
            case .airTime:           "cyan"
            case .consistencyScore:  "lime"
            }
        }
    }
}
