# SwiftUI-UniformGrid

SwiftUI grids with equal-sized cells that flow onto the next line. As many columns are used as fit at a minimum cell width, so one setting gives a single column on iPhone, two on iPad in portrait, and three or more on wider windows, like the cards in the Health app.

The package has two parts:

- `UniformGrid`: a grid of cards with a title at the top and a value at the bottom, so the values line up.
- `UniformGridLayout`: the plain layout, for cells you draw yourself.

## UniformGrid

Each `Section` is a card: its header is the card's title and its content is the card's value.

- **Any number of lines.** Titles and values wrap to the width of the card and are never truncated.
- **Values line up.** As in the Health app, the title is at the top leading corner and the value at the bottom leading corner, with the spare height between them. Every card is the same height, so the values line up across the whole grid; a value of several lines lines up by its last line.
- **Equal cards.** All cards have the same width, and the same height as the tallest card.
- **Columns from the width.** As many columns as fit at `minimumCellWidth`. Because only the available width counts, it adapts to Split View, Stage Manager and window resizing, not just to the device.
- **Dynamic Type.** Text grows with the user's text size, cards grow to fit it, and with a `@ScaledMetric` minimum width the grid drops to fewer, wider columns when the text gets too big for the current number. See [Dynamic Type](#dynamic-type).
- **Icons centred on the title.** Put the icon and title in an `HStack(alignment: .center)` in the header, and the icon stays level with the middle of a title of any number of lines. Give the icon a fixed width so the titles line up from card to card.

Requires iOS 18, macOS 15, tvOS 18, watchOS 11 or visionOS 2.

```swift
import SwiftUI
import UniformGrid

struct LocationView: View {
    // 1 column on iPhone, 2 on iPad portrait (mini to 13-inch), 3 or more on wider windows.
    @ScaledMetric private var minimumCellWidth: CGFloat = 340
    @ScaledMetric private var iconWidth: CGFloat = 26

    var body: some View {
        ScrollView {
            UniformGrid(minimumCellWidth: minimumCellWidth, spacing: 8) {
                Section {
                    Text(Measurement(value: 37.334606, unit: UnitAngle.degrees), format: .measurement(width: .narrow))
                        .font(.title2)
                        .foregroundStyle(.secondary)
                } header: {
                    HStack(alignment: .center) {
                        Image(systemName: "location.north.line")
                            .frame(width: iconWidth)
                        Text("Latitude")
                    }
                }
                // More sections…
            }
            .padding(.horizontal, 8) // leading and trailing edge padding
        }
    }
}
```

### Choosing the minimum width

A row fits `n` columns when `n × minimumCellWidth + (n − 1) × spacing` is no more than the grid's width. With 8 points of spacing and 8 points of padding at each edge:

| Width | Example | Columns at 340 |
|---|---|---|
| 440 | Largest iPhone, portrait | 1 |
| 744 | iPad mini, portrait | 2 |
| 1032 | 13-inch iPad, portrait | 2 |
| 1194 | 11-inch iPad, landscape | 3 |

Any value from about 334 to 360 gives these column counts. An iPhone in landscape is around 800 points wide once the safe area is taken off, so it shows 2 columns.

### Dynamic Type

`UniformGrid` supports Dynamic Type at every size, including the accessibility sizes:

- Titles use `.headline` and values use the font you give them, so both scale with the user's text size.
- Cards are as tall as their text needs, and titles and values wrap rather than truncate, so nothing is cut off at large sizes.
- Declare the minimum width with `@ScaledMetric` so it grows with the text. At larger sizes fewer columns fit, so the grid drops a column rather than squeezing the text into narrow cards. For example, an iPad in portrait goes from 2 columns to 1.
- Declare the icon width with `@ScaledMetric` too, so icons keep pace with the titles beside them.

The card's padding, corner radius and spacing don't scale.

## UniformGridLayout

A `Layout` for cells you draw yourself. All cells have equal width, and equal height based on the tallest cell. Configurable spacing between cells, which behaves like SwiftUI's built-in `Grid`.

```swift
import SwiftUI
import UniformGrid

struct UniformGridExample: View {

    var body: some View {
        ScrollView {
            UniformGridLayout(minimumCellWidth: 160, spacing: 8) { // spacing is the gap between cells
                ForEach(0..<20) { i in
                    ZStack {
                        Color.blue.opacity(0.2)
                            .cornerRadius(8)
                        Text("Item \(i)") // if this string is long it will wrap and all cells will have the same height
                            .padding()
                    }
                }
            }
            .padding(.horizontal, 8) // leading and trailing edge padding
        }
    }
}
```

<img width="761" alt="Screenshot 2025-06-23 at 11 46 21" src="https://github.com/user-attachments/assets/2d4498ea-dd6c-4135-8f93-625dc25e32c2" />
<img width="764" alt="Screenshot 2025-06-23 at 11 46 36" src="https://github.com/user-attachments/assets/848b8b59-9820-458c-8d68-494fba086261" />



## Installation

You can add this package via Swift Package Manager:

```swift
.package(url: "https://github.com/malhal/SwiftUI-UniformGrid.git", from: "1.0.0")
```

## License

MIT License — see [LICENSE](LICENSE) for details.
