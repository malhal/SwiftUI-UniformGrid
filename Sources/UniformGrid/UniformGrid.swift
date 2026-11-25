import SwiftUI

/// A grid of cards built from sections: each section's header is the card's title and its content is the card's value.
///
/// All cards have equal width and height, and as many columns are used as fit at `minimumCellWidth`.
/// Titles and values can be any number of lines. Like the cards in the Health app, the title is at the top and
/// the value at the bottom, with the spare space between them, so the values line up across the grid.
@available(iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2, *)
public struct UniformGrid<Content: View>: View {
    public var minimumCellWidth: CGFloat
    public var spacing: CGFloat
    @ViewBuilder public var content: Content

    public init(minimumCellWidth: CGFloat = 160, spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.minimumCellWidth = minimumCellWidth
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        UniformCardGridLayout(minimumCellWidth: minimumCellWidth, spacing: spacing) {
            // Each section becomes three subviews of the layout, in this order: background, title, value.
            ForEach(sections: content) { section in
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.background.secondary)
                VStack(alignment: .leading) {
                    section.header
                }
                .font(.headline)
                VStack(alignment: .leading) {
                    section.content
                }
            }
        }
    }
}

/// Places subviews in threes (background, title, value) as uniform cards, with each title at the top of its card
/// and each value at the bottom.
@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
struct UniformCardGridLayout: Layout {
    var minimumCellWidth: CGFloat
    var spacing: CGFloat
    var padding: CGFloat = 16
    var titleSpacing: CGFloat = 8

    /// The sizes worked out for one width.
    private struct Arrangement {
        var columns: Int
        var cellWidth: CGFloat
        var cellHeight: CGFloat
        var rowCount: Int
        /// The height of each cell's value, for placing it at the bottom of the cell.
        var valueHeights: [CGFloat]
    }

    private func arrangement(width: CGFloat, subviews: Subviews) -> Arrangement {
        let cellCount = subviews.count / 3
        let columns = max(1, min(Int((width + spacing) / (minimumCellWidth + spacing)), cellCount))
        let cellWidth = (width - CGFloat(columns - 1) * spacing) / CGFloat(columns)
        let contentProposal = ProposedViewSize(width: cellWidth - 2 * padding, height: nil)

        var valueHeights: [CGFloat] = []
        var cellHeight: CGFloat = 0
        for cell in 0..<cellCount {
            let titleHeight = subviews[cell * 3 + 1].sizeThatFits(contentProposal).height
            let valueHeight = subviews[cell * 3 + 2].sizeThatFits(contentProposal).height
            valueHeights.append(valueHeight)
            cellHeight = max(cellHeight, padding + titleHeight + titleSpacing + valueHeight + padding)
        }
        let rowCount = (cellCount + columns - 1) / columns
        return Arrangement(columns: columns, cellWidth: cellWidth, cellHeight: cellHeight, rowCount: rowCount, valueHeights: valueHeights)
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard subviews.count >= 3 else { return .zero }
        // With no width proposed (e.g. an ideal size is asked for), use a single column at the minimum width.
        let width = proposal.width ?? minimumCellWidth
        let arrangement = arrangement(width: width, subviews: subviews)
        let height = CGFloat(arrangement.rowCount) * arrangement.cellHeight + CGFloat(arrangement.rowCount - 1) * spacing
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard subviews.count >= 3 else { return }
        let arrangement = arrangement(width: bounds.width, subviews: subviews)
        let contentWidth = arrangement.cellWidth - 2 * padding

        for cell in 0..<(subviews.count / 3) {
            let row = cell / arrangement.columns
            let column = cell % arrangement.columns
            let x = bounds.minX + CGFloat(column) * (arrangement.cellWidth + spacing)
            let y = bounds.minY + CGFloat(row) * (arrangement.cellHeight + spacing)

            subviews[cell * 3].place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: arrangement.cellWidth, height: arrangement.cellHeight)
            )
            subviews[cell * 3 + 1].place(
                at: CGPoint(x: x + padding, y: y + padding),
                proposal: ProposedViewSize(width: contentWidth, height: nil)
            )
            // At the bottom of the cell, so the spare height is between the title and the value.
            subviews[cell * 3 + 2].place(
                at: CGPoint(x: x + padding, y: y + arrangement.cellHeight - padding - arrangement.valueHeights[cell]),
                proposal: ProposedViewSize(width: contentWidth, height: nil)
            )
        }
    }
}
