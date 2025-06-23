import SwiftUI

/// A SwiftUI layout that arranges child views in a uniform grid.
/// All cells have equal width and height based on the largest cell.
/// Cells flow onto the next line with configurable spacing.
public struct UniformGridLayout: Layout {
    public var spacing: CGFloat = 12

    public init(spacing: CGFloat = 12) {
        self.spacing = spacing
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let availableWidth = proposal.width, !subviews.isEmpty else {
            return .zero
        }

        let idealWidth = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let columns = max(1, min(Int((availableWidth + spacing) / (idealWidth + spacing)), subviews.count))

        let totalSpacingWidth = CGFloat(columns - 1) * spacing
        let cellWidth = (availableWidth - totalSpacingWidth) / CGFloat(columns)

        let cellHeight = subviews
            .map { $0.dimensions(in: ProposedViewSize(width: cellWidth, height: nil)).height }
            .max() ?? 0

        let rows = (subviews.count + columns - 1) / columns
        let totalSpacingHeight = CGFloat(rows - 1) * spacing
        let totalHeight = CGFloat(rows) * cellHeight + totalSpacingHeight

        return CGSize(width: availableWidth, height: totalHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }

        let availableWidth = bounds.width
        let idealWidth = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let columns = max(1, min(Int((availableWidth + spacing) / (idealWidth + spacing)), subviews.count))

        let totalSpacingWidth = CGFloat(columns - 1) * spacing
        let cellWidth = (availableWidth - totalSpacingWidth) / CGFloat(columns)

        let cellHeight = subviews
            .map { $0.dimensions(in: ProposedViewSize(width: cellWidth, height: nil)).height }
            .max() ?? 0

        for index in subviews.indices {
            let row = index / columns
            let col = index % columns

            let x = bounds.minX + CGFloat(col) * (cellWidth + spacing)
            let y = bounds.minY + CGFloat(row) * (cellHeight + spacing)

            subviews[index].place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: cellWidth, height: cellHeight)
            )
        }
    }
}
