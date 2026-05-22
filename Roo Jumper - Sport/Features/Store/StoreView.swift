import SwiftUI
import StoreKit

struct StoreView: View {

    var showDismissButton = true

    @Environment(SubscriptionManagerBPV.self) private var purchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                AppDesign.Colors.background.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: AppDesign.Spacing.lg) {
                        headerSection
                        statusSection
                        productsSection
                        restoreSection
                    }
                    .padding(.horizontal, AppDesign.Spacing.md)
                    .padding(.bottom, AppDesign.Spacing.xxl)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Upgrade")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if showDismissButton {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close", action: { dismiss() })
                            .foregroundStyle(AppDesign.Colors.dimWhite)
                    }
                }
            }
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        VStack(spacing: AppDesign.Spacing.md) {
            ZStack {
                Circle()
                    .fill(AppDesign.Colors.electricLime.opacity(0.12))
                    .frame(width: 100, height: 100)
                Image(systemName: "bolt.circle.fill")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(AppDesign.Colors.explosiveness)
            }
            .glowShadow(AppDesign.Colors.electricLime, radius: 24)

            Text("Unlock Your Full Potential")
                .font(AppDesign.Typography.headline)
                .foregroundStyle(AppDesign.Colors.brightWhite)
                .multilineTextAlignment(.center)

            Text("One-time purchase. Offline forever.")
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.dimWhite)
        }
        .padding(.top, AppDesign.Spacing.lg)
    }

    private var statusSection: some View {
        Group {
            switch purchaseManager.purchaseStatus {
            case .loading:
                HStack(spacing: AppDesign.Spacing.sm) {
                    ProgressView()
                        .tint(AppDesign.Colors.electricLime)
                    Text("Processing…")
                        .font(AppDesign.Typography.body)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                }
                .padding(AppDesign.Spacing.md)
                .background(AppDesign.Colors.surface2)
                .clipShape(.rect(cornerRadius: AppDesign.Radius.md))

            case .success(let msg):
                StatusBanner(message: msg, color: AppDesign.Colors.electricLime, icon: "checkmark.circle.fill")

            case .error(let msg):
                StatusBanner(message: msg, color: AppDesign.Colors.neonOrange, icon: "exclamationmark.circle.fill")

            case .restored:
                StatusBanner(message: "Purchases restored!", color: AppDesign.Colors.electricLime, icon: "checkmark.circle.fill")

            case .nothingToRestore:
                StatusBanner(message: "No previous purchases found.", color: AppDesign.Colors.dimWhite, icon: "info.circle.fill")

            case .initial:
                EmptyView()
            }
        }
        .animation(AppDesign.Anim.standard, value: purchaseManager.purchaseStatus)
    }

    private var productsSection: some View {
        VStack(spacing: AppDesign.Spacing.md) {
            ForEach(SubscriptionID.allCases, id: \.rawValue) { productID in
                let skProduct = purchaseManager.products.first(where: { $0.id == productID.rawValue })
                ProductCard(
                    productID: productID,
                    displayPrice: skProduct?.displayPrice ?? productID.fallbackPrice,
                    isPurchased: purchaseManager.isPurchased(productID),
                    isLoadingPrice: false,
                    onPurchase: {
                        if let product = skProduct {
                            Task { await purchaseManager.buyProduct(product) }
                        }
                    }
                )
            }
        }
    }

    private var restoreSection: some View {
        VStack(spacing: AppDesign.Spacing.sm) {
            Button(action: { Task { await purchaseManager.restorePurchases() } }) {
                Text("Restore Purchases")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.dimWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppDesign.Spacing.sm)
                    .background(AppDesign.Colors.surface2)
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
            }

            Text("Purchases are non-consumable one-time transactions. No subscriptions.")
                .font(AppDesign.Typography.caption)
                .foregroundStyle(AppDesign.Colors.mutedText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppDesign.Spacing.xl)

            HStack(spacing: AppDesign.Spacing.lg) {
                Link("Privacy Policy", destination: URL(string: "https://carryishelpzui.help/PkcWXK")!)
            }
            .font(AppDesign.Typography.caption)
            .foregroundStyle(AppDesign.Colors.mutedText)
        }
    }
}

// MARK: - ProductCard

private struct ProductCard: View {
    let productID: SubscriptionID
    let displayPrice: String
    let isPurchased: Bool
    let isLoadingPrice: Bool
    let onPurchase: () -> Void

    private var accentColor: Color {
        productID.accentColorName == "lime" ? AppDesign.Colors.electricLime : AppDesign.Colors.dynamicBlue
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.Spacing.md) {
            HStack(spacing: AppDesign.Spacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppDesign.Radius.sm)
                        .fill(accentColor.opacity(0.15))
                        .frame(width: 52, height: 52)
                    Image(systemName: productID.iconName)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(accentColor)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(productID.displayName)
                        .font(AppDesign.Typography.label)
                        .foregroundStyle(AppDesign.Colors.brightWhite)
                    Text(productID.tagline)
                        .font(AppDesign.Typography.caption)
                        .foregroundStyle(AppDesign.Colors.dimWhite)
                        .lineLimit(2)
                }
                Spacer()
                if isPurchased {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(AppDesign.Colors.electricLime)
                }
            }

            Divider().background(AppDesign.Colors.surface3)

            VStack(alignment: .leading, spacing: 6) {
                ForEach(productID.features, id: \.self) { feature in
                    HStack(spacing: AppDesign.Spacing.sm) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(accentColor)
                        Text(feature)
                            .font(AppDesign.Typography.caption)
                            .foregroundStyle(AppDesign.Colors.dimWhite)
                    }
                }
            }

            if !isPurchased {
                Button(action: onPurchase) {
                    HStack {
                        if isLoadingPrice {
                            ProgressView()
                                .tint(AppDesign.Colors.background)
                                .scaleEffect(0.8)
                        }
                        Text("Unlock – \(displayPrice)")
                            .font(AppDesign.Typography.title3)
                        Spacer()
                        Image(systemName: "lock.open.fill")
                    }
                    .foregroundStyle(AppDesign.Colors.background)
                    .padding(.vertical, AppDesign.Spacing.md)
                    .padding(.horizontal, AppDesign.Spacing.lg)
                    .background(
                        LinearGradient(
                            colors: [accentColor, accentColor.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(.rect(cornerRadius: AppDesign.Radius.full))
                }
                .sensoryFeedback(.impact(flexibility: .solid), trigger: isPurchased)
            } else {
                Label("Unlocked", systemImage: "checkmark.circle.fill")
                    .font(AppDesign.Typography.label)
                    .foregroundStyle(AppDesign.Colors.electricLime)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(AppDesign.Spacing.lg)
        .background(AppDesign.Colors.surface1)
        .clipShape(.rect(cornerRadius: AppDesign.Radius.xl))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.xl)
                .strokeBorder(
                    isPurchased ? AppDesign.Colors.electricLime.opacity(0.5) : AppDesign.Colors.surface3,
                    lineWidth: 1.5
                )
        }
    }
}

// MARK: - StatusBanner

private struct StatusBanner: View {
    let message: String
    let color: Color
    let icon: String

    var body: some View {
        HStack(spacing: AppDesign.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(color)
            Text(message)
                .font(AppDesign.Typography.body)
                .foregroundStyle(AppDesign.Colors.brightWhite)
            Spacer()
        }
        .padding(AppDesign.Spacing.md)
        .background(color.opacity(0.1))
        .clipShape(.rect(cornerRadius: AppDesign.Radius.md))
        .overlay {
            RoundedRectangle(cornerRadius: AppDesign.Radius.md)
                .strokeBorder(color.opacity(0.3), lineWidth: 1)
        }
    }
}

#Preview {
    StoreView()
        .environment(SubscriptionManagerBPV())
}
