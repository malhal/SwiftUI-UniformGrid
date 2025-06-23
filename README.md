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
import SwiftUI
import UniformGrid

struct UniformGridExample: View {

    var body: some View {
        ScrollView {
            UniformGridLayout(spacing: 8) {
                ForEach(0..<20) { i in
                    ZStack {
                        Color.blue.opacity(0.2)
                            .cornerRadius(8)
                        Text("Item \(i)") // if this string is long it will wrap and all cells will have the same height
                            .padding()
                    }
                }
            }
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
