import SwiftUI
import Testing
@testable import UniformGrid

@MainActor
struct UniformGridLayoutTests {
    @Test func defaults() {
        let layout = UniformGridLayout()
        #expect(layout.minimumCellWidth == 160)
        #expect(layout.spacing == 8)
    }

    @Test func customValues() {
        let layout = UniformGridLayout(minimumCellWidth: 340, spacing: 12)
        #expect(layout.minimumCellWidth == 340)
        #expect(layout.spacing == 12)
    }
}
