# SwiftUI-UniformGrid

A SwiftUI custom Layout that arranges child views in a grid with equal-sized cells.  
Cells flow onto the next line, widths and heights match the largest cell, and spacing behaves like SwiftUI’s built-in `Grid`.

## Features

- Automatically wraps cells onto new lines
- All cells have equal width and height based on the largest cell
- Configurable spacing between cells
- Supports dynamic content sizes and text wrapping
- Lightweight and easy to use

## Usage

```swift
import UniformGrid
import SwiftUI

struct ContentView: View {
    let items = Array(1...20).map { "Item \($0)" }

    var body: some View {
        UniformGridLayout(spacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
```

## Installation

You can add this package via Swift Package Manager:

```swift
.package(url: "https://github.com/yourusername/SwiftUI-UniformGrid.git", from: "1.0.0")
```

## License

MIT License — see [LICENSE](LICENSE) for details.
